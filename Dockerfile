FROM ubuntu:latest

# Env's
ENV DEBIAN_FRONTEND="noninteractive" 
ENV TZ="Europe/London"

# Installing packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --fix-missing -y python3-pip
RUN apt-get install --fix-missing -y ssh
RUN pip3 install ansible
RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/*

# Entrypoint
## Copy entrypoint
COPY entrypoint.sh /

## Mark entrypoint as executable
RUN chmod +x /entrypoint.sh

## Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]