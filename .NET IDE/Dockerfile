# Use the modified base image
FROM basharat1640/ide-base-image

# Download and install JetBrains Rider
RUN wget -O /tmp/rider.tar.gz https://download.jetbrains.com/rider/JetBrains.Rider-2023.1.4.tar.gz \
    && tar -xzf /tmp/rider.tar.gz -C /opt \
    && rm /tmp/rider.tar.gz \
    && mv /opt/JetBrains\ Rider-* /opt/rider

# Set environment variables
ENV DISPLAY=:1

# Copy and set up startup script
COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

# Expose Rider over web (adjust port if necessary)
EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["/entrypoint"]
