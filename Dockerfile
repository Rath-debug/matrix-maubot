# Start from the official Maubot image
FROM mau.dev/maubot/maubot:latest

# Set working directory
WORKDIR /opt/maubot

# Copy your config.yaml into the container
# (Railway will mount /data, but this ensures defaults are present)
COPY data/config.yaml /data/config.yaml

# Optionally, copy pre-bundled plugins
# COPY plugins/*.mbp /data/plugins/

# Expose the web UI port
EXPOSE 29316

# Define volume for persistence
VOLUME /data

# Default command
CMD ["/opt/maubot/docker/run.sh"]
