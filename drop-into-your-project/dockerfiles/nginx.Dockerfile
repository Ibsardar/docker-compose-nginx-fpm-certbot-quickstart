FROM nginx:1.18
LABEL MAINTAINER="IBRAHIM"
ARG NGINX_ROOT
# only ENV vars can be used in ENTRYPOINT, so we have to transfer it from ARG to ENV
ENV E_NGINX_ROOT $NGINX_ROOT


# create the nginx root folder and copy everything from here (docker-compose's context) to there
RUN mkdir -p ${NGINX_ROOT}
COPY . ${NGINX_ROOT}/


# allow execute on shell script and run it
RUN chmod +x ${NGINX_ROOT}/server/init_nginx.sh
ENTRYPOINT sh "${E_NGINX_ROOT}/server/init_nginx.sh"