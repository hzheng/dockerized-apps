FROM alpine:3.14

RUN apk update

# install python
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN apk add python3-dev
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

# install gcc etc.
RUN apk add build-base

# add 2 scripts that could be executed outside this container
ARG bean_file=/bean/main.bean
ARG bean_check_sh=/usr/bin/bcheck.sh
RUN echo '#!/bin/sh' > ${bean_check_sh}
RUN echo bean-check $bean_file >> ${bean_check_sh}
RUN chmod +x ${bean_check_sh}

ARG bean_query_sh=/usr/bin/bquery.sh
RUN echo '#!/bin/sh' > ${bean_query_sh}
RUN echo bean-query $bean_file >> ${bean_query_sh}
RUN chmod +x ${bean_query_sh}

# install and run fava
#RUN pip3 install beancount==2
RUN pip3 install fava

ENV FAVA_HOST "0.0.0.0"
#ENV BEANCOUNT_FILE ""
ENV main_bean=$bean_file
ENTRYPOINT exec "fava" $main_bean

#https://github.com/beancount/fava/blob/main/contrib/docker/Dockerfile
