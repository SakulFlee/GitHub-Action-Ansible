FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --fix-missing -y python3-pip && \
    pip3 install ansible && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Entrypoint
## Copy entrypoint
COPY entrypoint.sh /

## Mark entrypoint as executable
RUN chmod +x /entrypoint.sh

## Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]