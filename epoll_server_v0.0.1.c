#include <sys/epoll.h>
#include <unistd.h>     // for close
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <pthread.h>
#include <stdlib.h>
#include <errno.h>
#include <stdbool.h>
#include <time.h>
#define MAX_EVENT_NUM 100

int total_accept_num = 0;

typedef struct {
    int num1;
    int num2;
    int read_or_write;
} Task;

typedef struct Node {
    Task task;
    struct Node* next;
} Node;

typedef struct {
    Node* head;
    Node* tail;
    pthread_mutex_t mutex;
    pthread_cond_t cond;
} Queue;

typedef struct { 
    int num_threads; 
    pthread_t* threads; 
    Queue* queues; 
    int stop; 
} ThreadPool; 


static int set_non_blocking(int);
static int set_reuse(int);
static void initQueue(Queue* );
static void enqueue(Queue*, Task);
static Task dequeue(Queue* );

static void  handle_accept(int, int);
static void  handle_read(int, int);
static void  handle_write(int, int);
static void* executeTask(void* arg);
static void  initThreadPool(ThreadPool*, int);
static void  addTask(ThreadPool*, int, int, int);
static void  destroyThreadPool(ThreadPool*);
static int   create_socket(int);
static void* server_make();

int set_non_blocking(int fd) {

	int flag = fcntl(fd, F_GETFL, 0);
	if(flag == -1) 
		return -1;
	
	flag |= O_NONBLOCK;
	if(fcntl(fd, F_SETFL, flag) == -1)
		return -1;
	return 0;
}

int set_reuse(int i_listenfd) {
	int out = 2;
    return setsockopt(i_listenfd, SOL_SOCKET, SO_REUSEADDR, &out, sizeof(out));
}


void initQueue(Queue* queue) { 
    queue->head = NULL; 
    queue->tail = NULL; 
    pthread_mutex_init(&(queue->mutex), NULL); 
    pthread_cond_init(&(queue->cond), NULL); 
}

void enqueue(Queue* queue, Task task) { 
    Node* newNode = (Node*)malloc(sizeof(Node)); 
    newNode->task = task; newNode->next = NULL;
    pthread_mutex_lock(&(queue->mutex)); 
    if (queue->head == NULL) { 
        queue->head = newNode; 
        queue->tail = newNode; 
        pthread_cond_signal(&(queue->cond)); // 唤醒等待的线程 
	} else { 
		queue->tail->next = newNode; queue->tail = newNode; 
	} 
    pthread_mutex_unlock(&(queue->mutex)); 
} 

Task dequeue(Queue* queue) { 
    Task task; 
    pthread_mutex_lock(&(queue->mutex)); 
    while (queue->head == NULL) { 
        pthread_cond_wait(&(queue->cond), &(queue->mutex)); // 等待队列非空 
    }
    Node* temp = queue->head; 
    task = temp->task; 
    queue->head = queue->head->next; 
    free(temp); 
    if (queue->head == NULL) { 
        queue->tail = NULL; 
    } 
    pthread_mutex_unlock(&(queue->mutex)); 
    return task; 
}


void handle_accept (int serfd, int epoll_fd) {
	struct sockaddr_in cliaddr;
	int socklen = sizeof(cliaddr);
	struct epoll_event ev;
	int clifd;

	while( (clifd = accept(serfd, (struct sockaddr*)&cliaddr, &socklen)) > 0) {
	
		if(set_non_blocking(clifd) == -1) {
			perror("set_non_blocking2");
			return;
		}

		// epoll_ctl(epoll_fd, EPOLL_CTL_DEL, clifd, NULL);
		// close(clifd);
		
		ev.events = EPOLLIN | EPOLLET | EPOLLONESHOT;
		ev.data.fd = clifd;
		if( epoll_ctl(epoll_fd, EPOLL_CTL_ADD, clifd, &ev) == -1) {
			perror("epoll_ctl add");
			close(clifd);
		}	
	}
	if(clifd == -1) {
		if(errno != EAGAIN )
		printf("accept %s\n", strerror(errno));
		return;
	}
	// printf("%d %d\n", clifd, total_accept_num ++);
}

void handle_read (int client_fd, int epoll_fd) {
	char buf[512] = {0};
	ssize_t total_read = 0;
	ssize_t bytes_read;
	struct epoll_event ev;

	while(1) {
		bytes_read = read(client_fd, buf + total_read, 512 - total_read);
		if(bytes_read == -1) {
			if(errno == EAGAIN || errno == EWOULDBLOCK) {
				break;
			}else{
				perror("unknow read error");
				if( epoll_ctl(epoll_fd, EPOLL_CTL_DEL, client_fd, NULL) == -1)
				printf("epoll_ctl error");
				close(client_fd);
			}
		}else if(bytes_read == 0) {
			epoll_ctl(epoll_fd, EPOLL_CTL_DEL, client_fd, NULL);
			close(client_fd);
			return;
		}
		total_read += bytes_read;
	}
	// if(total_read != 123)
	// 	printf("%ld\n", total_read);

	ev.events = EPOLLOUT | EPOLLET ;
	ev.data.fd = client_fd;
	epoll_ctl(epoll_fd, EPOLL_CTL_MOD, client_fd, &ev);
	// handle_write(client_fd, epoll_fd);
}

void handle_write (int client_fd, int epoll_fd) {
	ssize_t n, nwrite;
	char buf[] = "HTTP/1.1 200 OK\r\n\r\nhello"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj"
		     "lajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdjlajsdf;ljlasjdlfjl;ajslkjf;lkasdj";
				 
	ssize_t data_size = strlen(buf);
	n = data_size;

	while(n > 0){
		nwrite = write(client_fd, buf + data_size -n, n);
		if(nwrite < n) {
			if(nwrite == -1 && errno != EAGAIN) {
				perror("write error");
			}
			break;
		}
		n -= nwrite;
	}
	

	epoll_ctl(epoll_fd, EPOLL_CTL_DEL, client_fd, NULL);
	close(client_fd);
}



void* executeTask(void* arg) {
    Queue* queue = (Queue*)arg;
    Task task;
    for (;;) {
        task = dequeue(queue);
        if (task.num1 == -1 && task.num2 == -1) {
            break;
        }
        switch (task.read_or_write) {
		case 1:
			handle_accept (task.num1, task.num2);
			break;
		case 2:
			handle_read (task.num1, task.num2);
			break;
		case 3:
			handle_write (task.num1, task.num2);
			break;
		default:
			break;
		}
	}
    return NULL;
}

void initThreadPool(ThreadPool* threadPool, int num_threads) {
    threadPool->num_threads = num_threads;
    threadPool->threads = (pthread_t*)malloc(num_threads * sizeof(pthread_t));
    threadPool->queues = (Queue*)malloc(num_threads * sizeof(Queue));
    threadPool->stop = 0;
    int i;
    for (i = 0; i < num_threads; i++) {
        initQueue(&(threadPool->queues[i]));
        pthread_create(&(threadPool->threads[i]), NULL, executeTask, &(threadPool->queues[i]));
    }
}


void addTask(ThreadPool* threadPool, int num1, int num2, int read_or_wite) { 
    Task task; 
    task.num1 = num1; 
    task.num2 = num2; 
    task.read_or_write = read_or_wite;
    
    int index = rand() % threadPool->num_threads; 
	// printf("%d\n", index);
    enqueue(&(threadPool->queues[index]), task); 
} 

void destroyThreadPool(ThreadPool* threadPool) { 
    int i; 
    threadPool->stop = 1; // 发送停止信号 
    for (i = 0; i < threadPool->num_threads; i++) { 
        enqueue(&(threadPool->queues[i]), (Task){-1, -1}); // 发送退出信号 
        pthread_cond_signal(&(threadPool->queues[i].cond)); // 唤醒等待的线程 
        pthread_join(threadPool->threads[i], NULL); 
        pthread_mutex_destroy(&(threadPool->queues[i].mutex)); 
        pthread_cond_destroy(&(threadPool->queues[i].cond)); 
    } 
    free(threadPool->threads); 
    free(threadPool->queues); 
}


int create_socket(int port) {

	int serfd;
	serfd = socket(AF_INET, SOCK_STREAM, 0);
	if(serfd == -1) {
		perror("socket error");
	}
	
	struct sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = INADDR_ANY;
	addr.sin_port = htons(port);

	if(set_reuse(serfd) == -1) {
		perror("set_reuse error");
	}
	if( set_non_blocking(serfd) == -1){
		perror("set_non_blocking error");
	}
	if( bind(serfd, (struct sockaddr*)&addr, sizeof(addr)) == -1) {
		perror("bind error");
	}
	if( listen(serfd, 5) == -1) {
		perror("listen error");
	}
	struct timeval tv = {0, 500};
    setsockopt(serfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(struct timeval));
	
	return serfd;
}

void* server_make() {
	
	int serfd = create_socket(8080);
	int epoll_fd = epoll_create(100);
	
	struct epoll_event ev;
    struct epoll_event evs[ MAX_EVENT_NUM ];

	if( set_non_blocking(epoll_fd) == -1) {
		perror("epoll set non blocking ");
	}

	ev.events = EPOLLIN | EPOLLET;
	ev.data.fd = serfd;
	epoll_ctl(epoll_fd, EPOLL_CTL_ADD, serfd, &ev);

	int evnum = 0;
	int tempfd;
	struct epoll_event tempev;

	ThreadPool threadPool1; 
    initThreadPool(&threadPool1, 7); 

	for(;;) {
		evnum = epoll_wait(epoll_fd, evs, MAX_EVENT_NUM, 10);
		// printf("%d\n", evnum);
		if(evnum == -1){
			perror("epoll wait");
			continue;
		}
			
		for(int i=0; i<evnum; i++) {
			
			if ((evs[i].events & EPOLLHUP)||(evs[i].events & EPOLLERR)) {
				epoll_ctl(epoll_fd, EPOLL_CTL_DEL, evs[i].data.fd, NULL);
				close(evs[i].data.fd);
			}else if(evs[i].data.fd == serfd) {
				// handle_accept(serfd, epoll_fd);
				addTask(&threadPool1, serfd, epoll_fd, 1);

			} else if( evs[i].events & EPOLLIN ) {
				// handle_read(evs[i].data.fd, epoll_fd);
				addTask(&threadPool1, evs[i].data.fd, epoll_fd, 2);

			} else if( evs[i].events & EPOLLOUT ) {
				// handle_write(evs[i].data.fd, epoll_fd);
				addTask(&threadPool1, evs[i].data.fd, epoll_fd, 3);
			} else {
				printf("unknow events\n");
			}
		}
	}
	close(serfd);
	close(epoll_fd);
}


int main() {

	for (int i = 0; i < 6; ++i) {
        pthread_t roundCheck;
		pthread_create(&roundCheck, NULL, server_make, NULL);
		pthread_join(roundCheck, NULL);
	}

	// server_make();

	return 0;
}
