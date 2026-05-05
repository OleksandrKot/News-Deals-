FROM node:20-alpine3.22 AS builder

# Install Python and community nodes in builder stage
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-numpy \
    py3-scipy \
    && pip3 install --break-system-packages matplotlib

# Install community nodes
RUN npm install -g @tavily/n8n-nodes-tavily n8n-nodes-htmlcsstopdf

# Final stage - use official n8n image
FROM n8nio/n8n:latest

USER root

# Copy Python from builder
COPY --from=builder /usr/bin/python3 /usr/bin/python3
COPY --from=builder /usr/lib/python3* /usr/lib/
COPY --from=builder /usr/lib/libpython3* /usr/lib/

# Copy community nodes from builder
COPY --from=builder /usr/local/lib/node_modules/@tavily /usr/local/lib/node_modules/@tavily
COPY --from=builder /usr/local/lib/node_modules/n8n-nodes-htmlcsstopdf /usr/local/lib/node_modules/n8n-nodes-htmlcsstopdf

USER node