FROM n8nio/n8n:latest

USER root

# Install Python via the distro's package manager if available
# n8n latest uses a minimal base, so we may need to use a different approach
RUN if command -v apt-get > /dev/null; then \
        sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list 2>/dev/null || true && \
        sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list 2>/dev/null || true && \
        sed -i '/updates/d' /etc/apt/sources.list 2>/dev/null || true && \
        apt-get update && \
        apt-get install -y python3 python3-pip python3-numpy python3-scipy python3-matplotlib && \
        apt-get clean; \
    elif command -v apk > /dev/null; then \
        apk add --no-cache python3 py3-pip py3-numpy py3-scipy && \
        pip3 install --break-system-packages matplotlib; \
    fi

USER node

# Ensure the default command is preserved
CMD ["n8n", "start"]