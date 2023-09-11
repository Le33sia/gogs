#!/usr/bin/env bash

# Install dependencies.
go get ./...

# Build app
go get https://github.com/Le33sia/gogs
go build -o bin/application application.go
