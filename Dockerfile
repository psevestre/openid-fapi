FROM python:2-slim-buster

RUN apt update && apt install -y wget
RUN pip install xml2rfc

WORKDIR /usr/local/bin

RUN wget https://github.com/mmarkdown/mmark/releases/download/v2.1.1/mmark_2.1.1_linux_amd64.tgz -O/tmp/mmark.tgz \
   && tar xzf /tmp/mmark.tgz

COPY make.sh /usr/local/bin/make.sh

WORKDIR /data

ENTRYPOINT [ "/bin/bash", "/usr/local/bin/make.sh" ]
