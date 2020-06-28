# bluster-slim doesn't have libtcnativ-1, which we need to run CF
# So, even if we have the huge image, I would like to reduce the
# running docker image size. So, introduce the multi-stage builder pattern.
#
#

## BuildEnv docker image size ~ 1.3 GB
FROM debian:buster AS builder
ENV WorkPath /home/ChannelFinder-env
RUN apt update
RUN apt install -y \
        make \
	maven \
	git \
	openjdk-11-jdk

WORKDIR $WorkPath
COPY . .
RUN make distclean && \
    make init && \
    make conf && \
    make build && \
    make install.docker
    #   make build MVN_OPTS=dependency:go-offline


## Multi-Stages build
## Running docker image size ~ 0.7 GB
FROM debian:buster

### RecCeiver PORT configuration.
### DO NOT CHANGE them
ENV RS_SERVER_PORT    5075
ENV RS_PORT_BROADCAST 5076
#
### ChannelFinder HTTP PORT  through Tomcat <<<<---- Most likely you would like to change this
ENV CF_PORT_HTTP      8080
#
### DO NOT CHANGE IT
ENV LDAP_SERVER_PORT  8389
#
### ChannelFinder HTTPS PORT through Tomcat
ENV CF_PORT_HTTPS     8443
#
### YOUR TIME ZONE  <<<<---- Most likely you would like to change this
ENV TZ America/Los_Angeles

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN apt update
RUN apt install -y \
        openjdk-11-jre \
	libtcnative-1

COPY ./docker/scripts/entrypoint.sh /entrypoint.sh
WORKDIR /opt/channelfinder
COPY --from=builder /opt/channelfinder .
# CF Port : http
EXPOSE ${CF_PORT_HTTP}/tcp
EXPOSE ${CF_PORT_HTTP}/udp
# CF PORT : https
EXPOSE ${CF_PORT_HTTPS}/tcp
EXPOSE ${CF_PORT_HTTPS}/udp
# RecCeiver Broadcast Port
EXPOSE ${RS_PORT_BROADCAST}/udp
# RecCeiver Server Port
EXPOSE ${RS_SERVER_PORT}/udp
# Embedded LDAP Port
EXPOSE ${LDAP_SERVER_PORT}/tcp
EXPOSE ${LDAP_SERVER_PORT}/udp
#

ENTRYPOINT ["/entrypoint.sh"]

