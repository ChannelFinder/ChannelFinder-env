#
#  author  : Jeong Han Lee
#  email   : jeonghan.lee@gmail.com
#  date    : Sat Sep 17 21:29:34 PDT 2022
#  version : 0.0.3
#
#

## BuildEnv docker image size : 672MB
FROM alpine:3.16 AS builder
ENV WorkPath /home/ChannelFinder-env
ARG RS_SERVER_PORT=5075
ARG RS_PORT_BROADCAST=5076
ARG CF_PORT_HTTP=8080
ARG CF_PORT_HTTPS=8443
ARG CF_INSTALL_LOCATION=/opt/channelfinder

ENV JAVA_HOME="/usr/lib/jvm/default-jvm/"
# We can check the package availbilities through docker run -t -i --entrypoint /bin/sh alpine:3.16
RUN apk update && apk add openjdk17 maven git make

WORKDIR $WorkPath
COPY . .
RUN echo "CF_PORT:=${CF_PORT_HTTP}" > configure/CONFIG_COMMON.local 
RUN echo "CF_INSTALL_LOCATION:=${CF_INSTALL_LOCATION}" > configure/CONFIG_SITE.local
RUN echo "JAVA_HOME:=/usr/lib/jvm/default-jvm/"    >> configure/CONFIG_COMMON.local
RUN echo "JAVA_PATH:=/usr/lib/jvm/default-jvm/bin" >> configure/CONFIG_COMMON.local
RUN echo "MAVEN_HOME:=/usr/"     >> configure/CONFIG_COMMON.local
RUN echo "MAVEN_PATH:=/usr//bin" >> configure/CONFIG_COMMON.local

RUN make distclean && \
    make init && \
    make conf && \
    make build && \
    make install.docker
    #   make build MVN_OPTS=dependency:go-offline

## Multi-Stages build
## Running docker image size : 240MB
FROM alpine:3.16
LABEL maintainer="Jeong Han Lee <jeonghan.lee@gmail.com>"

ARG BUILD_DATE
ARG BUILD_VERSION
ARG RS_SERVER_PORT=5075
ARG RS_PORT_BROADCAST=5076
ARG CF_PORT_HTTP=8080
ARG CF_PORT_HTTPS=8443
ARG CF_INSTALL_LOCATION=/opt/channelfinder
ARG TZ=America/Los_Angeles

# Labels.
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="alscontrols/channelfinder"
LABEL org.label-schema.description="EPICS ChannelFinder Docker Image"
LABEL org.label-schema.url="https://github.com/ChannelFinder/ChannelFinder-env/"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run --network=host --detach --rm --name=channelfinder alscontrols/channelfinder:latest"


### RecCeiver PORT configuration.
ENV RS_SERVER_PORT ${RS_SERVER_PORT}
ENV RS_PORT_BROADCAST ${RS_PORT_BROADCAST}
#

#
### DO NOT CHANGE IT
ENV LDAP_SERVER_PORT 8389
#
### ChannelFinder HTTP PORT  through Tomcat
ENV CF_PORT_HTTP ${CF_PORT_HTTP}
### ChannelFinder HTTPS PORT through Tomcat
ENV CF_PORT_HTTPS ${CF_PORT_HTTPS}
### ChannelFinder Installation Loation
ENV CF_INSTALL_LOCATION ${CF_INSTALL_LOCATION}

### YOUR TIME ZONE
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
### Install minimal packages for ChannelFinder
RUN apk add --no-cache bash openjdk17-jre tomcat-native tzdata

WORKDIR ${CF_INSTALL_LOCATION}
COPY --from=builder ${CF_INSTALL_LOCATION} .
##
# CF Port : http
EXPOSE $CF_PORT_HTTP/tcp
EXPOSE $CF_PORT_HTTP/udp
# CF PORT : https
EXPOSE $CF_PORT_HTTPS/tcp
EXPOSE $CF_PORT_HTTPS/udp
# RecCeiver Broadcast Port
EXPOSE $RS_PORT_BROADCAST/udp
# RecCeiver Server Port
EXPOSE $RS_SERVER_PORT/udp
# Embedded LDAP Port
EXPOSE $LDAP_SERVER_PORT/tcp
EXPOSE $LDAP_SERVER_PORT/udp
#
COPY ./docker/scripts/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
