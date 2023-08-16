FROM golang:1.18 AS builder

WORKDIR /app
COPY . .
RUN go build -o gogs

FROM debian:bullseye-slim  

WORKDIR /app
COPY --from=builder /app/gogs /app/gogs

EXPOSE 3000
ENTRYPOINT ["/app/gogs", "web"]
