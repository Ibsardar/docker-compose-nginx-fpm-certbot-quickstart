FROM php:7.4-fpm
LABEL MAINTAINER="IBRAHIM"
ARG NGINX_ROOT
# only ENV vars can be used in ENTRYPOINT, so we have to transfer it from ARG to ENV
ENV E_NGINX_ROOT $NGINX_ROOT


# create the nginx root folder and copy everything from here (docker-compose's context) to there
RUN mkdir -p ${NGINX_ROOT}
COPY . ${NGINX_ROOT}/


# set permissions of root folder
RUN find ${NGINX_ROOT} -type f -exec chmod 664 {} \;
RUN find ${NGINX_ROOT} -type d -exec chmod 775 {} \;


# allow execute on shell script and run it
RUN chmod +x ${NGINX_ROOT}/server/init_phpfpm.sh
# comment out for default/custom entrypoint
#ENTRYPOINT sh "${E_NGINX_ROOT}/server/init_phpfpm.sh"


EXPOSE 9000