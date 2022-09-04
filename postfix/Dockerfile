#Dockerfile for a Postfix email relay service
FROM ubuntu:20.04

RUN apt-get update && apt-get install -y postfix rsyslog mailutils

COPY run.sh /
RUN chmod +x /run.sh
RUN newaliases

EXPOSE 25
#ENTRYPOINT ["/run.sh"]
CMD ["/run.sh"]
