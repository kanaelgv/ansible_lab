# Pull base image.
FROM ubuntu

# Install Python.
RUN \
  apt-get update && \
  apt-get install -y python3 \
    python3-dev \
    python3-pip \
    python3-virtualenv \
    openssh-server \
    net-tools \
    iputils-ping \
    nano \
    python-is-python3 \
    curl && \
  rm -rf /var/lib/apt/lists/*

# Define working directory.
WORKDIR /ans

# Install Ansible.
RUN pip install ansible

# Define default command.
CMD ["bash"]
