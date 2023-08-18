FROM golang:alpine3.17 AS binarybuilder

WORKDIR /app
COPY . .
RUN go mod download
COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o gogs


FROM alpine:3.17

WORKDIR /app
COPY --from=build-stage /gogs /gogs

EXPOSE 22 3000

ENTRYPOINT ["/gogs", "web"]
