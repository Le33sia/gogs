FROM golang:1.20 AS build-stage
WORKDIR /app
RUN git clone --depth=1 https://github.com/gogs/gogs.git .
COPY . .
RUN go get
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/gogs/gogs
FROM debian:bullseye-slim
ENV USER=gogs

WORKDIR /app/gogs
COPY --from=build-stage app/gogs app2/gogs
EXPOSE 22 3000
ENTRYPOINT ["/gogs", "web"]




