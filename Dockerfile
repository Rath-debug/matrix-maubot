FROM dock.mau.dev/maubot/maubot:c3a52ed45b940920e9443c38069f3b2a2fc83298-amd64

WORKDIR /opt/maubot

# Copy config where Maubot expects it
COPY data/config.yaml /data/config.yaml

# Ensure plugin directories exist
RUN mkdir -p /data/plugins /data/trash /data/dbs

EXPOSE 8080

CMD ["/opt/maubot/docker/run.sh"]
