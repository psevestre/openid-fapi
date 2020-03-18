FROM alpine:edge

VOLUME /data
EXPOSE 80

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN wget https://github.com/mmarkdown/mmark/releases/download/v2.2.4/mmark_2.2.4_linux_amd64.tgz -O/tmp/mmark.tgz \
   && tar xzf /tmp/mmark.tgz && mv mmark /usr/local/bin/mmark

RUN apk update && apk add supervisor nginx bash inotify-tools python3 py3-pip libxml2-dev libxml2 gcc python3-dev build-base py3-lxml
RUN pip install xml2rfc
RUN mkdir /run/nginx
RUN mkdir /var/www/html

COPY support/nginx-default.conf /etc/nginx/conf.d/default.conf

COPY support/supervisord.conf /etc/supervisord.conf
COPY support/make-rfc-from-md.sh /usr/local/bin/make-rfc-from-md.sh
COPY support/watchandrebuild.sh /usr/local/bin/watchandrebuild.sh
WORKDIR /data

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]


