ChannelFinder-Springboot Docker image
===

## User should be in the docker group

```
sudo groupadd docker
sudo usermod -aG docker ${USER}
```
Note that one will have to log out and to log in to take effect! One should look at two references [1,2] to understand security issues. 


## Pull the release image from a registry (hub.docker.com)

```
docker pull jeonghanlee/channelfinder:4-v0.1.0
```


## Run

* Run with console outputs 
```
docker run --network=host  --name=channelfinder jeonghanlee/channelfinder:4-v0.1.0
```

* Run in the detach mode
```
docker run --network=host --detach --rm --name=channelfinder jeonghanlee/channelfinder:4-v0.1.0
```

* Run in order to access the container without the channelfinder service
```
docker run -i -t --entrypoint /bin/bash jeonghanlee/channelfinder:4-v0.1.0
```


* Run with the local disk mount
```
docker run -i -t -v ${HOME}/docker_data:/data --entrypoint /bin/bash jeonghanlee/channelfinder:4-v0.1.0
```
, where `${HOME}/docker_data` is the host path, which will be created if it doesn't exist, and `/data` is a volume in the docker container.


## Status, Stop, and restart

* Check the channelfinder service is running

```
docker ps -f name=channelfinder
```

* Check the service logs
```
docker logs channelfinder
```

* Stop the service
```
docker stop channelfinder
```

* Restart the service
```
docker start channelfinder
```

* Remove the channelfinder
```
docker rm -f channelfinder
```

* Remove all leftover containers
```
docker rm $(docker ps -aq)
```

## Building the Docker image

* Clone
```
git clone https://github.com/jeonghanlee/ChannelFinder-env/
```
* Configure desired CF configuration

Few variables one has to change them carefully. `CF_HOST`, `CF_PORT`, `ES_HOST`, `INSTALL_LOCATION`, and so on. So, one change them, one should check the Dockerfile carefully, because it is the hard-coded file.

* Default the build with the docker
```
make build.docker
```


## References
[1] https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface

[2] https://docs.docker.com/engine/security/rootless/