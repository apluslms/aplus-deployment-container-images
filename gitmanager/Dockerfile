FROM ubuntu:20.04
ARG TAG

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Helsinki

WORKDIR /

RUN apt-get update && apt-get -y install git gettext libjpeg-dev libxml2-dev libxslt-dev zlib1g-dev python3 python3-dev python3-pip uwsgi-core uwsgi-plugin-python3 sqlite3 libsqlite3-dev rsync

RUN pip3 install kubernetes

RUN git clone --branch ${TAG} https://github.com/apluslms/gitmanager.git
RUN pip3 install -r gitmanager/requirements.txt -r gitmanager/requirements_prod.txt
RUN pip3 install --upgrade --force-reinstall certifi

# Alias python3 -> python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install and set correct locale
RUN apt-get update && apt-get -y install locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

WORKDIR /gitmanager
RUN python3 manage.py compilemessages
