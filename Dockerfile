FROM n8nio/n8n:latest

USER root

# Install Python and chart dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-numpy \
    py3-scipy \
    && pip3 install --break-system-packages matplotlib

USER node