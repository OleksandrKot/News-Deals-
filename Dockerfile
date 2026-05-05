FROM n8nio/n8n:latest

USER root

# Install Python 3 and required packages
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-numpy \
    py3-matplotlib \
    py3-scipy \
    && rm -rf /var/cache/apk/*

USER node
