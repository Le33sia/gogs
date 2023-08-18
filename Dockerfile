FROM golang:alpine3.11 AS binarybuilder


WORKDIR /app
COPY . .
RUN go mod download
COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o gogs



FROM alpine3.11

WORKDIR /app
COPY --from=build-stage /gogs /gogs

EXPOSE 22 3000

ENTRYPOINT ["/gogs", "web"]
