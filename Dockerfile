FROM n8nio/n8n:latest-debian

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-numpy \
    python3-scipy \
    && pip3 install --break-system-packages matplotlib \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER node