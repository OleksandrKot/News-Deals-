FROM n8nio/n8n:latest-debian

USER root

# Fix Debian Buster EOL repos
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/updates/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER node

# Install custom n8n nodes
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install @tavily/n8n-nodes-tavily n8n-nodes-htmlcsstopdf

CMD ["n8n"]