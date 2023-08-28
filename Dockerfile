FROM golang:1.20 AS build-stage
RUN adduser -D git   # Add the 'git' user
USER git             # Set the user to 'git'
WORKDIR /app
COPY . .
RUN go get
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o gogs
FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y git
WORKDIR /app
COPY --from=build-stage /app/gogs /gogs
USER git                                                  #user git
EXPOSE 22 3000
ENTRYPOINT ["/gogs", "web"]
