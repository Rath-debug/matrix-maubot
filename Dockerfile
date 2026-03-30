FROM dock.mau.dev/maubot/maubot:c3a52ed45b940920e9443c38069f3b2a2fc83298-amd64

WORKDIR /opt/maubot

# Copy config template; envsubst will render it to /data/config.yaml at startup
COPY data/config.yaml.template /data/config.yaml.template

# Copy plugin bundles into /data/plugins so they persist across redeploys
COPY plugins /data/plugins

# Ensure plugin directories exist
RUN mkdir -p /data/plugins /data/trash /data/dbs && \
    chmod 0777 /data/plugins /data/trash /data/dbs && \
    printf '#!/bin/sh\nmkdir -p /data/plugins /data/trash /data/dbs\nchmod 0777 /data/plugins /data/trash /data/dbs\nenvsubst < /data/config.yaml.template > /data/config.yaml\nexec /opt/maubot/docker/run.sh\n' > /start.sh && \
    chmod +x /start.sh

EXPOSE 29316

# Startup: recreate runtime dirs, set permissions, then run Maubot
CMD ["/start.sh"]
