# ChannelFinder-env
[![Debian 11](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/debian11.yml/badge.svg)](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/debian11.yml)
[![Rocky8](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/rocky8.yml/badge.svg)](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/rocky8.yml)
[![Ubuntu Latest](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/ubuntu.yml)
[![ChannelFinderService](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/docker.yml/badge.svg)](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/docker.yml)
[![Linter Run](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/linter.yml/badge.svg)](https://github.com/jeonghanlee/ChannelFinder-env/actions/workflows/linter.yml)

Configuration Environment for ChannelFinderService at <https://github.com/ChannelFinder/ChannelFinderService>

## Pre-requirement packages

```
git make sudo tree maven
```

## JAVA

The following four variables must be defined. Please setup them according to one's systems configuration.

```bash
        echo "JAVA_HOME:=/usr/"      > ./configure/CONFIG_COMMON.local
        echo "JAVA_PATH:=/usr/bin"  >> ./configure/CONFIG_COMMON.local
        echo "MAVEN_HOME:=/usr/"    >> ./configure/CONFIG_COMMON.local
        echo "MAVEN_PATH:=/usr/bin" >> ./configure/CONFIG_COMMON.local
```

## Support OS [Debian 11 (EOL: 2024-06-01/2026-08-15), Rocky8 (EOL: 2029-05-31)]

It will works with other systems. Please check github action workflows.

```bash
make init
make conf
make build
make install
make sd_start
make sd_status
```

## Docker Image

The Docker image is hosted at https://hub.docker.com/orgs/alscontrols
And for further information, please see [docs/Docker.md](docs/Docker.md) :whale:

