FROM nginx:alpine
 
COPY nginx.conf /etc/nginx/nginx.conf
COPY jenkins.conf syncthing.conf redmine.conf beancount.conf /etc/nginx/conf.d/
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.disabled

