FROM ubuntu:20.04
ARG TAG

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Helsinki

WORKDIR /

# Install required Ubuntu packages
RUN apt-get update && apt-get -y install git gettext libjpeg-dev libxml2-dev libxslt-dev zlib1g-dev python3 python3-dev python3-pip python3-psycopg2 uwsgi-core uwsgi-plugin-python3 sqlite3 libsqlite3-dev

# Clone software
RUN git clone --branch ${TAG} https://github.com/apluslms/mooc-grader.git
RUN mkdir mooc-grader/uploads

# Install python packages
RUN pip3 install -r mooc-grader/requirements.txt
RUN pip3 install uwsgi kubernetes
RUN pip3 install --upgrade --force-reinstall certifi

# Alias python3 -> python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install and set correct locale
RUN apt-get update && apt-get -y install locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

WORKDIR /mooc-grader
RUN python3 manage.py compilemessages
