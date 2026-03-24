# Build from the official Maubot image
FROM mau.dev/maubot/maubot:latest

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
