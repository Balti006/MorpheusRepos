# Use the modified base image
FROM basharat1640/ide-base-image

# Download and install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set environment variables (if necessary)
ENV DISPLAY=:1

# Copy and set up startup script
COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

# Expose code-server port (adjust port if necessary)
EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["/entrypoint"]

