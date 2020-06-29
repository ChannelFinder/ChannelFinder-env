


## Check an image id, which one would like to do tag

```
docker ps
```

## Login the docker hub

```
docker login
```

### Create tag and push

The first argument is `IMAGE ID`, the second one is a version. Then one has the following tag
`jeonghanlee/channelfinder:4-v0.1.0`

```
bash docker/scripts/push_to_hub -s "24924741269d" -t "4-v0.1.1"
```

### Pull the image from docker hub
```
docker pull jeonghanlee/channelfinder:4-v0.1.0
```
