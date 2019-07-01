
FROM golang:1.10 as builder
WORKDIR /go/src/github.com/rajgaekwad/godocker
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
MAINTAINER rajgaekwad 
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/rajgaekwad/godocker/app .
COPY avengers.json .
EXPOSE 3000
CMD ["./app"]
