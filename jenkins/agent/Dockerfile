FROM jenkins/ssh-agent:jdk11

# install dev-tools
RUN apt-get update && apt-get install -y gnupg curl
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
RUN apt update && apt install -y mariadb-client mongodb-org-tools rsync

# install Python and some libraries
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv
RUN python3 -m venv /opt/venv
RUN /opt/venv/bin/pip install todoist_api_python
# ensure the virtual environment is activated by default
ENV PATH="/opt/venv/bin:$PATH"
