# Use the modified base image
FROM basharat1640/ide-base-image

# Download PyCharm tar.gz file from JetBrains website
RUN wget -O /tmp/pycharm.tar.gz https://download.jetbrains.com/python/pycharm-community-2023.1.4.tar.gz

# Install PyCharm
RUN tar -xzf /tmp/pycharm.tar.gz -C /opt \
    && rm /tmp/pycharm.tar.gz \
    && mv /opt/pycharm-* /opt/pycharm

# Set environment variables
ENV DISPLAY=:1

# Copy and set up startup script
COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

# Expose PyCharm over web (adjust port if necessary)
EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["/entrypoint"]
