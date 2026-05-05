FROM node:20-alpine3.22 AS builder

# Install Python with ALL dependencies for venv creation
RUN apk add --no-cache \
    python3 \
    python3-dev \
    py3-pip \
    py3-numpy \
    py3-scipy \
    gcc \
    musl-dev \
    linux-headers \
    && pip3 install --break-system-packages matplotlib virtualenv

FROM n8nio/n8n:latest

USER root

# Copy full Python installation from builder
COPY --from=builder /usr/bin/python3* /usr/bin/
COPY --from=builder /usr/lib/python3.12 /usr/lib/python3.12
COPY --from=builder /usr/lib/libpython* /usr/lib/
COPY --from=builder /usr/lib/libgcc* /usr/lib/
COPY --from=builder /usr/lib/libstdc* /usr/lib/
COPY --from=builder /lib/ld-musl* /lib/

# Ensure venv works
RUN python3 -m ensurepip --default-pip 2>/dev/null || true

USER node

# Pre-create venv directory (n8n will populate it)
RUN mkdir -p /home/node/.n8n/.venv