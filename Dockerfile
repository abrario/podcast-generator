FROM ubuntu:latest

# Install system dependencies + software-properties-common
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    git

# Add the deadsnakes PPA and install Python 3.10 + pip
RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y python3.10 python3.10-distutils && \
    ln -s /usr/bin/python3.10 /usr/bin/python3

# Manually install pip (because python3.10 needs it separately)
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3

# Install Python packages
RUN pip3 install PyYAML

# Copy your scripts
COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# Make entrypoint executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
