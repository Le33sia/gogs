# Use an official Golang image as the base image
FROM golang:1.16 AS build

# Set the working directory inside the container
WORKDIR /go/gogs/gogs

# Clone Gogs repository
RUN git clone --depth=1 https://github.com/gogs/gogs.git .

# Build Gogs
RUN go build -o gogs

# Start a new stage
FROM debian:bullseye-slim

# Set environment variables for Gogs configuration
ENV USER=gogs
ENV GOGS_CUSTOM=/data/gogs

# Create a non-root user
RUN useradd -r -u 1000 -U -d /data -s /bin/bash -G users ${USER}

# Install dependencies and configure
RUN apt-get update && \
    apt-get install -y ca-certificates sqlite3 git && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /data/gogs && \
    chown -R ${USER}:${USER} /data/gogs

# Copy the compiled Gogs binary from the build stage
COPY --from=build /go/gogs/gogs /app/gogs

# Set the user
USER gogs
WORKDIR /app

# Expose Gogs port
EXPOSE 3000

# Start Gogs
CMD ["./gogs", "web"]
