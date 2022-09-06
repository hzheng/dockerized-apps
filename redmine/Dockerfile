FROM redmine:5

RUN apt-get update

WORKDIR /usr/src/redmine
COPY configuration.yml config/

COPY run.sh /
RUN chmod +x /run.sh
CMD ["/run.sh"]
