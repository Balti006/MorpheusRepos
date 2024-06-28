# Use the modified base image
FROM basharat1640/ide-base-image

# Download IntelliJ IDEA tar.gz file from JetBrains website
RUN wget -O /tmp/intellij.tar.gz https://download.jetbrains.com/idea/ideaIC-2024.1.2.tar.gz

# Install IntelliJ IDEA
RUN tar -xzf /tmp/intellij.tar.gz -C /opt \
    && rm /tmp/intellij.tar.gz \
    && mv /opt/idea-IC-* /opt/intellij

# Set environment variables
ENV DISPLAY=:1

# Copy and set up startup script
COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

# Expose IntelliJ IDEA over web (adjust port if necessary)
EXPOSE 8080

# Run the startup script
CMD ["/entrypoint"]
