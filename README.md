ChannelFinder-env
===
Configuration Environment for ChannelFinder-SpringBoot at https://github.com/ChannelFinder/ChannelFinder-SpringBoot

## Role
In order to download, install, setup all relevant components, one should do many steps manually. This repository was designed for the easy-to-reproducible environment for ChannelFinder-SprintBoot.

## Requirements

* JAVA
* ElasticSearch 6.3.1
* Apache Tomcat Native Library (Debian 10 `libtcnative-1`)
* LDAP (Configuration is needed if an external one)

## Makefile Rules

### `make init`
* Download the ChannelFinder-SpringBoot
* Switch to a specific version defined in `$(SRC_TAG)` in `configure/RELEASE`

### `make conf`
* Apply several site-specific files into the downloaded sources. Please see `site-template`

### `make build`
* Build `ChannelFinder.jar` as a Spring Boot jar file, located in `target` path.

### `make install`
* NYI

### `make distclean`
* Remove the downloaded ChannelFinder-SprintBoot source file



## Reference




