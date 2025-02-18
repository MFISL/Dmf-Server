/* 
    *  Copyright 2023 Ajax
    *
    *  Licensed under the Apache License, Version 2.0 (the "License");
    *  you may not use this file except in compliance with the License.
    *
    *  You may obtain a copy of the License at
    *
    *    http://www.apache.org/licenses/LICENSE-2.0
    *    
    *  Unless required by applicable law or agreed to in writing, software
    *  distributed under the License is distributed on an "AS IS" BASIS,
    *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    *  See the License for the specific language governing permissions and
    *  limitations under the License. 
    *
    */

	
#define _GNU_SOURCE
#include <dm_server.h>
#include <dm_master.h>

#include <sched.h>
#include <dm_shm.h>

#define MYTYPE(x) _Generic((x), \
    int: "int",                 \
    float: "float",             \
    double: "double",           \
    test_t: "test_t"            \
)

typedef struct test_t {
    int a;
    char b;
} test_t ;

// ulimit -c unlimited    -c

// dmesg -T

// sysctl -w net.core.somaxconn=32768
// sysctl -w net.ipv4.tcp_max_syn_backlog=65535
// sysctl -p

int main(int arg, char* args[]) {
#if 0
    // type compare
    test_t ss;
    printf("%s \n", MYTYPE(ss));
    // transform force
    test_t* obj = (test_t*)malloc(sizeof(test_t));
    obj->a = 1;
    int* a = (int*)malloc(sizeof(int));
    a = (int*)obj;
    printf("%d\n", *a);
    free(obj);  // attention to double free
#endif
    
#if 1
    events_ssl_init();

    ulimit();

    struct sigaction sa;
    sa.sa_handler = SIG_IGN;
    sigaction(SIGALRM, &sa, 0);
    sigaction(SIGPIPE, &sa, 0);

    int serfd_http        = create_socket( SERVER_DEFAULT_PORT );
    int serfd_https       = create_socket( 443 );
    int serfd_http_proxy  = create_socket( 9000 );
    int serfd_https_proxy = create_socket( 8443 );
    int serfd_tcp_proxy   = create_socket( 9090 );
    int ports_num = 5;
    lis_inf_t *fds = (lis_inf_t*)malloc(sizeof(lis_inf_t) * ports_num);
    
    fds[0].fd = serfd_http;         fds[0].type = HTTP;
    fds[1].fd = serfd_https;        fds[1].type = HTTPS;        // HTTPS
    fds[2].fd = serfd_http_proxy;   fds[2].type = HTTP_PROXY;   // http reverse
    fds[3].fd = serfd_https_proxy;  fds[3].type = HTTPS_PROXY;  // https reverse
    fds[4].fd = serfd_tcp_proxy;    fds[4].type = TCP_PROXY;    // tcp reverse


	// start_server(fds, ports_num);

    // epoll_ssl_server(serfd_https);
    shm_data_t* sd = create_get_shm(66666);
    sd->accept_mutex = 0;
    sd->accept_num = 0;
    sd->read_num = 0;
    sd->close_num = 0;
    sd->write_num = 0;

    if (arg == 2 && (strcmp(args[1], "master") == 0))
        master_daemonize();
    
    master_start_multi_process_server(fds, ports_num);

    // start_server(fds, ports_num);
#endif

	return 0;
}