# ChannelFinder-env
[![Debian 11](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/debian11.yml/badge.svg)](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/debian11.yml)
[![Rocky8](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/rocky8.yml/badge.svg)](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/rocky8.yml)
[![Ubuntu Latest](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/ubuntu.yml)
[![ChannelFinderService](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/docker.yml/badge.svg)](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/docker.yml)
[![Linter Run](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/linter.yml/badge.svg)](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/linter.yml)

Configuration Environment for ChannelFinderService at <https://github.com/ChannelFinder/ChannelFinderService>

## Pre-requirement packages

```
git make sudo tree maven jq
```

## Elasticsearch

Three configurations are changed for the elasticsearch. 

* Elasticsearch JVM options : [default] `-Xms1g -Xmx1g`
* Elasticsearch `pack.security.enabled` option : [default] false
* Elasticsearch configuration location : [default] `/etc/elasticsearch`

These options can be changed through the variables `CF_ES_JAVA_OPTS`, `CF_ES_CONF_PATH`, and `CF_ES_XPACK_SECURITY` in `configure/CONFIG_SITE`.

### Debian 11 / Rocky 8

```
make install.esdeb or install.esrpm
make conf.es
make conf.es.show
make start.es
make status.es
```

Note that `conf.es` will use the `pack.security.enabled: false` in `elasticsearch.yml`, where is in `/etc/elasticsearch`.
The log file `elasticsearch.log` is located in `/etc/elasticsearch`.

### macOS (M1)


```bash
make install.esmac
make conf.macos
make conf.esmac
make conf.es.show
make start.esmac
make stop.esmac
```

The log file `elasticsearch.log` is located in the installation location log folder of the elastisserch.


## JAVA

The following four variables must be defined. Please setup them according to one's systems configuration.

```bash
        echo "JAVA_HOME:=/usr/"      > ./configure/CONFIG_COMMON.local
        echo "JAVA_PATH:=/usr/bin"  >> ./configure/CONFIG_COMMON.local
        echo "MAVEN_HOME:=/usr/"    >> ./configure/CONFIG_COMMON.local
        echo "MAVEN_PATH:=/usr/bin" >> ./configure/CONFIG_COMMON.local
```

## Support OS 

### Debian 11 (EOL: 2024-06-01/2026-08-15), Rocky8 (EOL: 2029-05-31)

It will works with other systems. Please check github action workflows.

```bash
make init
make build
make install
make sd_start
make sd_status
make mapping
```

ChannelFinder log is shown in `/var/log/syslog`.

```bash
tail -f /var/log/syslog
``` 

## macOS (tested with aarch64 with brew)

```bash
make init
make conf.macos
make conf
make build
make run
make mapping
make mapping.clean
```

## ChannelFinder Configuration

Please see [docs/ChannelFinderConf.md](docs/ChannelFinderConf.md).

## Run Demo

Please see [docs/ChannelFinderDemo.md](docs/ChannelFinderDemo.md).


```
make run
make demo
make demo.clean
```

## Docker Image

The Docker image is hosted at https://hub.docker.com/orgs/alscontrols
And for further information, please see [docs/Docker.md](docs/Docker.md) :whale:

