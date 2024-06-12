FROM golang:1.20 as builder

WORKDIR /app

COPY . .

RUN env CGO_ENABLED=0 GOOS=linux go build -o go-blueprint

FROM alpine

WORKDIR /

COPY --from=builder /app/go-blueprint /go-blueprint

RUN chmod +x /go-blueprint

ENTRYPOINT ["./go-blueprint"]
