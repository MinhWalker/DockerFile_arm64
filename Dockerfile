FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git

ENV GO111MODULE=on

WORKDIR $GOPATH/src/backend-github-trending/
COPY . .

RUN go mod init backend-github-trending

WORKDIR cmd/pro
RUN go build -o /go/bin/hello

FROM alpine:3.4
COPY --from=builder /go/bin/hello /go/bin/hello

RUN chmod +x /go/bin/hello
ENTRYPOINT ["/bin/sh","-c","/go/bin/hello"]