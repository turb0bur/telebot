FROM quay.io/projectquay/golang:1.20 AS builder
WORKDIR /go/src/app
COPY . .
ARG TARGETOS=linux
ARG TARGETARCH=amd64
RUN make build TARGETOS=$TARGETOS TARGETARCH=$TARGETARCH

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/telebot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs
ENTRYPOINT ["./telebot"]
