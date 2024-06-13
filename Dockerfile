FROM golang:1.20 as builder

WORKDIR /app

COPY . .

RUN env CGO_ENABLED=0 GOOS=linux go build -o go-blueprint

FROM golang:1.22.4-alpine

RUN apk add --no-cache git

WORKDIR /

COPY --from=builder /app/go-blueprint /usr/local/bin/go-blueprint

RUN chmod +x /usr/local/bin/go-blueprint

ENTRYPOINT ["go-blueprint"]
