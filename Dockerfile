# Stage 1: Build the Go tools
FROM golang:1.21-alpine AS builder

RUN apk add --no-cache git gcc musl-dev

# Install standard recon tools
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
RUN go install -v github.com/sensepost/gowitness@latest

# Stage 2: Final lightweight image
FROM alpine:latest

# Install bash and chromium (required for gowitness headless browser)
RUN apk add --no-cache bash chromium

# Copy compiled binaries from builder
COPY --from=builder /go/bin/subfinder /usr/local/bin/
COPY --from=builder /go/bin/httpx /usr/local/bin/
COPY --from=builder /go/bin/gowitness /usr/local/bin/

# Set up the working directory
WORKDIR /app

# Copy the OmniRecon files
COPY run_recon.sh .
COPY wordlists/ ./wordlists/

# Ensure script is executable
RUN chmod +x run_recon.sh

# Set the entrypoint to the script
ENTRYPOINT ["/app/run_recon.sh"]
