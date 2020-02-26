ChannelFinder-env
===
Configuration Environment for ChannelFinder-SpringBoot at https://github.com/ChannelFinder/ChannelFinder-SpringBoot

## Role
In order to download, install, setup all relevant components, one should do many steps manually. This repository was designed for the easy-to-reproducible environment for ChannelFinder-SprintBoot.

## Requirements

**Note that this implementation is valid only for ChannelFinder-SpringBoot**


### Apache Tomcat Native Library and Maven

* Debian 10

```
apt install maven libtcnative-1
```


* CentOS 7

```
yum install maven tomcat-native 
```


* CentOS 8
One can use `yum` instead of `dnf`. `epel-release` is needed. 
```
dnf install maven tomcat-native 
```




### JDK 8 or newer

### ElasticSearch 6.3.1

Please use the exact version of Elasticsearch **6.3.1**.

* Debian 10
```
$ wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.1.deb
$ sudo apt install ./elasticsearch-6.3.1.deb
```

* CentOS 7
```
$ wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.1.rpm
$ sudo yum install ./elasticsearch-6.3.1.rpm
```

* CentOS 8
```
$ wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.1.rpm
$ sudo dnf install ./elasticsearch-6.3.1.rpm
```

* ES Systemd service

```
$ sudo systemctl daemon-reload
$ sudo systemctl enable elasticsearch
$ sudo systemctl start elasticsearch
```
Please make sure the service is running via `systemd status elasticsearch`. One can do the same things with embedded make rules such as 


###  LDAP 
Configuration is needed if an external one.


## Few Makefile Rules

### `make init`
* Download the ChannelFinder-SpringBoot
* Switch to a specific version defined in `$(SRC_TAG)` in `configure/RELEASE`

### `make es_mapping`

* Do maping CF index into ElasticSearch
* For CentOS7, one should disable SELINUX before doing this. Please check `/etc/selinux/config`.

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
* Run `systemctl daemon-reload` for the updated `channelfinder.serive` systemd file. 
* Enable the channelfinder systemd service.

### `make distclean`
* Remove the downloaded ChannelFinder-SprintBoot source file

### `make vars`
* Print out interesting variables
* One can use `make PRINT.VARIABLE_NAME` to print out them. For example,  `make PRINT.INSTALL_LOCATION`.

## A typical example to configure the ChannelFinder service

Note that this example has the assumption which ES service is running.


```
$ make init
$ make es_mapping
$ make conf
$ make build
$ make install
$ sudo systemctl start channelfinder
```

Note that we create the alias name of the `channelfinder.service` as cf.servie. So one can start it `sudo systemctl start cf` also. Sometimes with CentOS8, the service doesn't start properly. In this case, please try with `SELINUX=disabled` in `/etc/selinux/config`.

## While evaluating its configuration 

Modify `application.properties` or `ldif` file, and then run the following command:
```
$ make restart
```

## Customize site-specific configuration
Please consult two files in `configure` path, such as `RELEASE` and `CONFIG_SITE`. There are few comments on there. If you are familiar with the standard EPICS building system [1], it should be easy to understand them, because we mimic that concept into this repository. 


## Reference

[1] https://epics-controls.org/


