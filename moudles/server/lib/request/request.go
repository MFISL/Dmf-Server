package request

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/chenhg5/collection"
)

// const (
// 	REQUEST_OK             = 0
// 	NONE                   = 1
// 	UNKNOW_INVALID         = 2
// 	FIRST_LINE_INVALID     = 3
// 	METHOD_INVALID         = 4
// 	REQUEST_NEED_READ_MORE = 5

// 	INVALID_HEADERS = 6
// )

type RequestError struct {
	Code    int
	Message string
}

var (
	RequestOk           = &RequestError{0, "Request OK"}
	None                = &RequestError{1, "None"}
	UnknowInvalid       = &RequestError{2, "Unknow invalid"}
	FirstLineInvalid    = &RequestError{3, "First line invalid"}
	MethodInvalid       = &RequestError{4, "Method invalid"}
	RequestNeedReadMore = &RequestError{5, "Request need read more"}
	InvalidHeaders      = &RequestError{6, "Invalid headers"}
	ProtocolInvalid     = &RequestError{7, "Protocol invalid"}
	PathInvalid         = &RequestError{8, "Path invalid"}
)

func (e *RequestError) Error() string {
	return fmt.Sprintf("Request error code: %d, Message: %s", e.Code, e.Message)
}

// this struct is saved in Event
// which contaions event's method,path,servername(headers)
type Req struct {
	// HTTP first line
	Method   string `name:"request_method"`
	Path     string `name:"request_uri"`
	Protocol string
	Encoding []string
	// HTTP Headers
	Headers   map[string]string
	HeaderLen int
	Body      []byte
	BodyLen   int
	H2        bool
}

var http_method = []string{
	"GET",
	"POST",
	"PUT",
	"DELETE",
	"HEAD",
	"OPTIONS",
	"TRACE",
	"CONNECT",
}

var http_protocol = []string{
	"HTTP/0.9",
	"HTTP/1.0",
	"HTTP/1.1",
	"HTTP/2",
	"HTTP/3",
}

func ReqInit(h2 bool) *Req {
	return &Req{
		Headers: make(map[string]string),
		H2:      h2,
	}
}

// flush request struct
func (r *Req) Flush() {}

// get request header
func (r *Req) GetHeader(key string) string {
	return r.Headers[key]
}

func (r *Req) GetHost() string {
	return r.Headers["Host"]
}

func (r *Req) GetConnection() string {
	return r.Headers["Connection"]
}

func (r *Req) GetContentType() string {
	return r.Headers["Content-Type"]
}

func (r *Req) GetContentLength() string {
	return r.Headers["Content-Length"]
}

func (r *Req) GetUpgrade() string {
	return r.Headers["Upgrade"]
}

func (r *Req) GetTransferEncoding() string {
	return r.Headers["Transfer-Encoding"]
}

func (r *Req) GetAuthorization() string {
	return r.Headers["Authorization"]
}

// whether the request connection is keep alive
func (r *Req) IsKeepalive() bool {
	conn := r.GetConnection()
	if conn == "keep-alive" {
		return true
	} else {
		return false
	}
}

// get request row bytes
func (r *Req) ByteRow() []byte {
	rowStr := r.Method + " " +
		r.Path + " " +
		r.Protocol + "\r\n"
	for k, v := range r.Headers {
		rowStr = rowStr + k + ": " + v + "\r\n"
	}
	rowStr = rowStr + "\r\n"

	rowByte := []byte(rowStr)
	rowByte = append(rowByte, r.Body...)

	return rowByte
}

// parse row tcp str to a req object
func (r *Req) ParseHeader(request_byte string) error {
	request := request_byte
	if request == "" {
		return None
	}
	requestLine := strings.Split(request, "\r\n")
	if len(requestLine) < 2 {
		return UnknowInvalid // invalid request
	}
	parts := strings.Split(requestLine[0], " ")
	if len(parts) != 3 {
		return FirstLineInvalid // invalid first line
	}
	if !collection.Collect(http_method).Contains(parts[0]) {
		return MethodInvalid // invalid method
	}
	r.Method = parts[0]

	if parts[1] == "" {
		return PathInvalid
	}
	r.Path = parts[1]

	if !collection.Collect(http_protocol).Contains(parts[2]) {
		return ProtocolInvalid // invalid protocol
	}
	r.Protocol = parts[2]

	lines := requestLine[1:]
	if len(lines) == 1 {
		return RequestNeedReadMore
	}

	for i := 0; i < len(lines); i++ {
		if lines[i] == "" && len(lines) > i+1 { // there is "\r\n\r\n", \r\n"
			return RequestOk // valid
		}
		parts := strings.SplitN(lines[i], ":", 2)
		if len(parts) == 1 { // No ":"
			return InvalidHeaders // invalid headers
		}
		key := strings.TrimSpace(parts[0])
		// key = strings.ToTitle(key)
		key = strings.ToUpper(key[:1]) + key[1:]
		value := strings.TrimSpace(parts[1])
		r.Headers[key] = value
	}

	return RequestNeedReadMore // valid
}

func (r *Req) RequestHeaderValid() bool {
	return true
}

func (r *Req) TryFixHeader(other []byte) error {
	return nil
}

// get request's body
func (r *Req) ParseBody(tmpByte []byte) {
	var i int // last byte position before \r\n\r\n
	var remain_len int
	var res []byte

	total_len := len(tmpByte)
	for i = 0; i < total_len-4; i++ {
		if tmpByte[i] == byte(13) && tmpByte[i+1] == byte(10) &&
			tmpByte[i+2] == byte(13) && tmpByte[i+3] == byte(10) {
			break
		}
	}

	remain_len = total_len - i - 4

	if remain_len == 0 {
		res = (tmpByte[i+4:])
	} else {
		res = (tmpByte[i+4:])[:remain_len]
	}

	r.Body = res
}

func (r *Req) RequestBodyValid() bool {
	contentType := r.GetContentType()
	if strings.Index(contentType, "multipart/form-data") != -1 {
		po := strings.Index(contentType, "boundary=")
		boundaryStr := contentType[po+len("boundary="):]
		if strings.Contains(string(r.Body), boundaryStr+"--") {
			return true
		} else {
			return false
		}
	}

	contentLength := r.GetContentLength()
	if contentLength != "" {
		n, err := strconv.Atoi(contentLength)
		if err != nil {
			panic(err)
		}
		if len(r.Body) != n { // content length not equal to body length
			return false
		}
	}

	return true
}

func (r *Req) TryFixBody(other []byte) bool {
	r.Body = append(r.Body, other...)
	if !r.RequestBodyValid() {
		return false
	} else {
		return true
	}
}
