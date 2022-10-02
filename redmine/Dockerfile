FROM redmine:5

RUN apt-get update

WORKDIR /usr/src/redmine
COPY configuration.yml config/

COPY run.sh /
RUN chmod +x /run.sh

RUN ln -s /data/plugins /usr/src/redmine/plugins
RUN ln -s /data/public/themes /usr/src/redmine/public/themes
RUN ln -s /data/files /usr/src/redmine/files

CMD ["/run.sh"]
