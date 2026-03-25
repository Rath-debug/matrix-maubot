FROM dock.mau.dev/maubot/maubot:c3a52ed45b940920e9443c38069f3b2a2fc83298-amd64

WORKDIR /opt/maubot

# Copy config where Maubot expects it
COPY data/config.yaml /data/config.yaml

# Bundle the reminder plugin with the image.
COPY xyz.maubot.reminder-v0.2.2.mbp /opt/maubot/bundled-plugins/

# Ensure plugin directories exist in the image filesystem
RUN mkdir -p /data/plugins /data/trash /data/dbs


EXPOSE 29316

# Recreate runtime directories in case /data is mounted over image contents.
CMD ["/bin/sh", "-c", "mkdir -p /data/plugins /data/trash /data/dbs && chmod 0777 /data/plugins /data/trash /data/dbs && cp -n /opt/maubot/bundled-plugins/*.mbp /data/plugins/ 2>/dev/null || true && exec /opt/maubot/docker/run.sh"]
