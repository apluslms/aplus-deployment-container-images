FROM nginx:1.23.4 AS build

RUN apt update && apt install -y wget git mercurial build-essential libxml2-utils xsltproc lsb-release devscripts lintian quilt libssl-dev libpcre2-dev libpcre3-dev zlib1g-dev

WORKDIR /root/
RUN wget https://hg.nginx.org/pkg-oss/raw-file/default/build_module.sh && chmod +x build_module.sh
RUN mkdir -p /root/nginx-modules/deb/

RUN ./build_module.sh --skip-depends -y -o /root/nginx-modules/deb/ -n shibboleth -v `nginx -v 2>&1 | sed -n -e 's|^.*/||p' | tr -d '\n'` https://github.com/nginx-shib/nginx-http-shibboleth.git \
    && ./build_module.sh --skip-depends -y -o /root/nginx-modules/deb/ -n headersmore -v `nginx -v 2>&1 | sed -n -e 's|^.*/||p' | tr -d '\n'` https://github.com/openresty/headers-more-nginx-module.git \
    && rm -f /root/nginx-modules/deb/*-dbg_*.deb



FROM nginx:1.23.4

COPY --from=build /root/nginx-modules/deb/*.deb /tmp/
RUN dpkg -i /tmp/*.deb

RUN apt update && apt install -y shibboleth-sp-common shibboleth-sp-utils supervisor 

COPY supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir /run/shibboleth && chown _shibd:_shibd /run/shibboleth
RUN adduser nginx _shibd

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
