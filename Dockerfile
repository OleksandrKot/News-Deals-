FROM node:20-alpine3.22 AS builder

# Install Python with venv module
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-numpy \
    py3-scipy \
    python3-dev \
    py3-virtualenv \
    && pip3 install --break-system-packages matplotlib

# Final stage
FROM n8nio/n8n:latest

USER root

# Copy Python + venv module from builder
COPY --from=builder /usr/bin/python3 /usr/bin/python3
COPY --from=builder /usr/lib/python3.12 /usr/lib/python3.12
COPY --from=builder /usr/lib/libpython3.12.so* /usr/lib/

# Create symlink for venv
RUN ln -s /usr/lib/python3.12/venv /usr/lib/python3.12/ensurepip 2>/dev/null || true

USER node