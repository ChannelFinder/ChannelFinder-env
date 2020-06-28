ChannelFinder-Springboot Docker image
===

Work in progress

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



## Building the Docker image

```
git clone https://github.com/jeonghanlee/ChannelFinder-env/
cd ChannelFinder-env/docker
docker build . -t local-cf docker/Dockerfile
```


