# Build from the official Maubot image pinned to a digest
FROM dock.mau.dev/maubot/maubot:c3a52ed45b940920e9443c38069f3b2a2fc83298-amd64

# Set working directory
WORKDIR /opt/maubot

# Copy your config.yaml into the container image
# Railway will mount its own volume at /data, but this ensures defaults exist
COPY data/config.yaml /data/config.yaml

# Optionally pre-bundle plugins
# COPY plugins/*.mbp /data/plugins/

# Expose the web UI port
EXPOSE 29316

# Default command
CMD ["/opt/maubot/docker/run.sh"]
