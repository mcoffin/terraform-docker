FROM public.ecr.aws/docker/library/alpine:latest

RUN apk update && apk add terraform ca-certificates
