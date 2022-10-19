FROM alpine:latest

RUN apk update && apk add terraform ca-certificates
