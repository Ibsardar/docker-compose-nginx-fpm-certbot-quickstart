FROM certbot/dns-digitalocean:v1.11.0
LABEL MAINTAINER="IBRAHIM"
ARG NGINX_ROOT
# only ENV vars can be used in ENTRYPOINT, so we have to transfer it from ARG to ENV
ENV E_NGINX_ROOT $NGINX_ROOT


# make the nginx root folder and copy needed server files there
RUN mkdir -p ${NGINX_ROOT}/server
COPY ./server/init_certbot.sh ${NGINX_ROOT}/server/init_certbot.sh


# allow execute on shell script and run it
RUN chmod +x ${NGINX_ROOT}/server/init_certbot.sh
ENTRYPOINT sh "${E_NGINX_ROOT}/server/init_certbot.sh"