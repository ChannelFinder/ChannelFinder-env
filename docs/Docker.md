ChannelFinder-Springboot Docker image
===

## User should be in the docker group

```
sudo groupadd docker
sudo usermod -aG docker ${USER}
```
Remember that one will have to log out and to log in to take effect!

https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface"



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


## Run it

* Run
```
docker run --network=host  --name=channelfinder jeonghanlee/channelfinder:YYMMDDHHMMSS
```

* Run with detach
```
docker run --network=host --detach --name=channelfinder jeonghanlee/channelfinder:YYMMDDHHMMSS
```

```
docker run --network=host --detach --rm --name=channelfinder jeonghanlee/channelfinder:YYMMDDHHMMSS
```




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
