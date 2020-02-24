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
Please make sure the service is running via `systemd status elasticsearch`. One can do the same things with embedded make rules such as 
```
$ make es_install
$ make es_start
$ make es_status
```
$ make es_mapping

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

### `make es_mapping`
* Do maping CF index into ElasticSearch

### `make es_mapping_clean`
* Remove all existent CF related mapping from ElasticSearch


### `make conf`
* Apply several site-specific files into the downloaded sources. Please see `site-template`

### `make build`
* Build `ChannelFinder-*.jar` as a Spring Boot jar file, located in `target` path.

### `make install`
* `sudo` permission is required.
* Install `ChannelFinder-*.jar` in `target` path into `INSTALL_LOCATION` defined in `configure/CONFIG_SITE`
* Install `cf.conf` into `INSTALL_LOCATION`. This file contains java options, defined in `site-template/cf.conf`
* Install `channelfinder.service` into a default systemd path `/etc/systemd/system`. Note that `channelfinder.service` is generated from `site-template/cf.service.in` file with `INSTAL_LOCATION`, `JAVA_PATH`, and `CF_JAR_NAME` which are defined in `configure/CONFIG_SITE`.

### `make setup`
* Prepare the channelfinder systemd service

### `make distclean`
* Remove the downloaded ChannelFinder-SprintBoot source file

## A typical example to configure the ChannelFinder service

Note that this example has the assumption which ES service is running.


```
$ make init
$ make es_mapping
$ make conf
$ make build
$ make install
$ make setup
$ sudo systemctl start channelfinder
```

Note that we create the alias name of the `channelfinder.service` as cf.servie. So one can start it `sudo systemctl start cf` also. 


## Reference




