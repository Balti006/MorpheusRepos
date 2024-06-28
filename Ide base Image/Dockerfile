# Use a base image with necessary dependencies (adjust as needed)
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        xvfb \
        netcat \
        s6 \
        xdg-utils \
        x11vnc \
        novnc \
        websockify \
        software-properties-common \
        wget \
        curl \
        openjdk-17-jdk \
        maven \
    && rm -rf /var/lib/apt/lists/*

# Install Python 3.12
RUN add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y python3.12 \
    && rm -rf /var/lib/apt/lists/*

# Install .NET SDK 8.0 and runtimes
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y dotnet-sdk-8.0 aspnetcore-runtime-8.0 dotnet-runtime-8.0 \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV DISPLAY=:1

# Expose IntelliJ IDEA over web (adjust port if necessary)
EXPOSE 5900
EXPOSE 6080


