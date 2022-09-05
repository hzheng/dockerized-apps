FROM ubuntu:20.04

RUN apt-get update && apt-get install -y postfix rsyslog mailutils
# for dev convenience
RUN apt-get install -y net-tools vim

COPY run.sh /
RUN chmod +x /run.sh
RUN newaliases

#ENTRYPOINT ["/run.sh"]
CMD ["/run.sh"]
