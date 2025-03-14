# Stage 1: Build
FROM golang:1.22.5-alpine AS builder

# Set environment variables
WORKDIR /app

# Copy go module files and download dependencies
COPY go.mod ./
RUN go mod download

# Copy the source code
COPY . .

# Build the application
RUN go build -o myapp .

# Stage 2: Runtime
FROM alpine:latest

# Set work directory
WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/myapp .

COPY --from=builder /app/static ./static

# Expose necessary port (if applicable)
EXPOSE 8080

# Set the entrypoint
CMD ["./myapp"]
