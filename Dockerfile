FROM n8nio/n8n:latest

USER root

# Install Python dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install custom n8n nodes as root (fixes permissions)
RUN npm install -g @tavily/n8n-nodes-tavily n8n-nodes-htmlcsstopdf

USER node

CMD ["n8n"]