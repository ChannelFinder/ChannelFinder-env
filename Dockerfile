# docker build -t jeonghanlee/cf-spring:alpha .
# docker run -d -p 8080:8080 jeonghanlee/cf-spring:alpha
# docker run -d --network host --name channelfinder jeonghanlee/cf-spring:alpha
# docker logs 
# bluster-slim doesn't have libtcnativ-1
FROM debian:buster
RUN apt update
RUN apt install -y apt-utils
RUN apt install -y make \
    	openjdk-11-jdk \
	maven \
	git \
	libtcnative-1
WORKDIR /home/ChannelFinder-env
COPY . .
RUN make distclean
RUN make init
RUN make conf
RUN make build
RUN make docker_install

WORKDIR /opt/channelfinder
EXPOSE 8080
ENTRYPOINT ["/usr/bin/java","-jar","/opt/channelfinder/ChannelFinder-4.0.0.jar"]
