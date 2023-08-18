FROM golang:1.20 AS build-stage


WORKDIR /app
COPY . .
RUN go mod download
COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o gogs



FROM debian:bullseye-slim

WORKDIR /app
COPY --from=build-stage /gogs /gogs

EXPOSE 22 3000

ENTRYPOINT ["/gogs", "web"]
