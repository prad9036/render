FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

# Install aria2, byobu, and required utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    aria2 \
    byobu \
    curl \
    ca-certificates \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Install GoTTY binary
RUN curl -sL https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz \
    | tar -xz -C /usr/local/bin \
    && chmod +x /usr/local/bin/gotty

# Default port
EXPOSE 8080

# Launch GoTTY running Byobu with write access enabled (-w)
# Dynamically binds to Render's $PORT variable or defaults to 8080
CMD ["sh", "-c", "gotty --port ${PORT:-8080} -w byobu"]
