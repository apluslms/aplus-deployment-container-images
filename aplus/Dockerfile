FROM ubuntu:20.04
ARG TAG
ARG REPO_URL=https://github.com/apluslms/a-plus.git

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Helsinki
WORKDIR /
RUN apt-get update && apt-get install -y git gettext python3-pip python3-psycopg2 python3-reportlab python3-reportlab-accel uwsgi-core uwsgi-plugin-python3 libpq-dev locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN git clone --branch ${TAG} ${REPO_URL}
WORKDIR /a-plus
RUN pip3 install -r requirements.txt -r requirements_prod.txt
RUN pip3 install git+https://github.com/apluslms/aalto-sisu@0.4.1#egg=aalto-sisu==0.4.1
RUN pip3 install --upgrade --force-reinstall certifi
RUN mkdir static media

# Django requires BASE_URL in order to exec compilemessages
COPY local_settings.py /a-plus/local_settings.py
RUN python3 manage.py compilemessages
