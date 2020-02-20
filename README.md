ChannelFinder-env
===
Configuration Environment for ChannelFinder-SpringBoot at https://github.com/ChannelFinder/ChannelFinder-SpringBoot

## Role
In order to download, install, setup all relevant components, one should do many steps manually. This repository was designed for the easy-to-reproducible environment for ChannelFinder-SprintBoot.

## Requirements

**Note that the current implementation is valid only for the Debian 10**

### JDK 8 or newer

### ElasticSearch 6.3.1

* Debian 10
```
$ wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.1.deb
$ sudo dpkg -i elasticsearch-6.3.1.deb
$ sudo systemd enable elasticsearch
$ sudo systemd start elasticsearch
```
Please make sure the service is running via `systemd status elasticsearch`


### Apache Tomcat Native Library and Maven

* Debian 10

```
apt install maven libtcnative-1
```

* CentOS 8


###  LDAP 
Configuration is needed if an external one.

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

## A typical example to configure

```
$ make es_install
$ make es_start
$ make es_status
$ make es_mapping
$ make init
$ make conf
$ make build
$ make install (NYI)
$ make setup (NYI)
```



## Reference




