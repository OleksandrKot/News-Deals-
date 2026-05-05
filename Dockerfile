FROM n8nio/n8n:latest

USER root

RUN apk update && \
    apk add --no-cache python3 py3-pip py3-numpy py3-scipy && \
    pip3 install --break-system-packages matplotlib && \
    rm -rf /var/cache/apk/*

USER node