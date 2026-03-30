FROM dock.mau.dev/maubot/maubot:c3a52ed45b940920e9443c38069f3b2a2fc83298-amd64

WORKDIR /opt/maubot

# Copy config where Maubot expects it
COPY data/config.yaml /data/config.yaml

# Copy plugin bundles into /data/plugins so they persist across redeploys
COPY plugins /data/plugins

# Ensure plugin directories exist
RUN mkdir -p /data/plugins /data/trash /data/dbs && \
    chmod 0777 /data/plugins /data/trash /data/dbs && \
    echo '#!/bin/sh\n\
    mkdir -p /data/plugins /data/trash /data/dbs\n\
    chmod 0777 /data/plugins /data/trash /data/dbs\n\
    envsubst < /data/config.yaml.template > /data/config.yaml\n\
    exec /opt/maubot/docker/run.sh' > /start.sh && \
    chmod +x /start.sh

EXPOSE 29316

# Startup: recreate runtime dirs, set permissions, then run Maubot
CMD ["/start.sh"]
