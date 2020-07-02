ChannelFinder-Springboot Docker image
===

## User should be in the docker group

```bash
sudo groupadd docker
sudo usermod -aG docker ${USER}
```
Note that one will have to log out and to log in to take effect! One should look at two references [1,2] to understand security issues. 


## Pull the release image from a registry (hub.docker.com)

```bash
docker pull jeonghanlee/channelfinder:4-v0.1.0
```


## Run

* Run with console outputs 
```bash
docker run --network=host  --name=channelfinder jeonghanlee/channelfinder:4-v0.1.0
```

* Run in the detach mode
```bash
docker run --network=host --detach --rm --name=channelfinder jeonghanlee/channelfinder:4-v0.1.0
```

* Run in order to access the container without the channelfinder service
```bash
docker run -i -t --entrypoint /bin/bash jeonghanlee/channelfinder:4-v0.1.0
```

* Run with the local disk mount
```bash
docker run -i -t -v ${HOME}/docker_data:/data --entrypoint /bin/bash jeonghanlee/channelfinder:4-v0.1.0
```
, where `${HOME}/docker_data` is the host path, which will be created if it doesn't exist, and `/data` is a volume in the docker container.


## Status, Stop, and restart

* Check the channelfinder service is running

```bash
docker ps -f name=channelfinder
```

* Check the service logs
```bash
docker logs channelfinder
```

* Stop the service
```bash
docker stop channelfinder
```

* Restart the service
```bash
docker start channelfinder
```

* Remove the channelfinder
```bash
docker rm -f channelfinder
```

* Remove all leftover containers
```bash
docker rm $(docker ps -aq)
```

## Building the Docker image

* Clone
```bash
git clone https://github.com/jeonghanlee/ChannelFinder-env/
```
* Configure desired CF configuration

I assume that ES service stays in the same Docker host where CF container. One variable `CF_PORT` for http connection can be configured.


* Default the build with the docker
```bash
make build.docker
```


## References
[1] <https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface>

[2] <https://docs.docker.com/engine/security/rootless/>
