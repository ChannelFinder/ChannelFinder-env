# ChannelFinder Configuration

## Tomcat generic service

It is always better to check the Tomcat service first, because the current configuration uses `8080` as the channelfinder port. 

```bash
systemctl status tomcat{9}
systemctl stop tomcat{9}
systemctl disable tomcat{9}
```

## Create Indexes and add mapping information

We have three index(s), which I don't use `indices`, because it is a slightly different definition in ES, such as

```bash
channelfinder
cf_tags
cf_properties
```

This can be created via `make mapping`, which is our preference, or set `elasticsearch.create.indices: true` in `applicaton.properties`


### `make mapping`

This is the Makefile rule, to call `cf_es_configuration.bash` in `site-template` path. It uses the same json files to create three index(s) with `CF_QUERY_SIZE` configuration. We have the following Makefile rules:

```
make mapping
make mapping.clean
make mapping.verify
```

And the script will allow us to explore them in detail.

```
Usage    : site-template/cf_es_configuration.bash  args

              possbile args

              mapping            : CF index mapping
              mappingClean       : Delete all CF index
              mappingVerify      : Verify the existing mappings
              metaField 'search' : mapping, search, ....
              h                  : this screen
```

### `application.properties`

* Before `make build`

```
echo "CF_CREATE_INDEX:=true" >> configure/CONFIG_SITE.local
```

After the channelfinder service starts, one can see the following log

```bash
2022-09-20 22:40:21.084  INFO 78852 --- [           main] org.phoebus.channelfinder.ElasticConfig  : Initializing a new Transport clients.
2022-09-20 22:40:22.079  INFO 78852 --- [           main] org.phoebus.channelfinder.ElasticConfig  : Created index: channelfinder : acknowledged true
2022-09-20 22:40:22.666  INFO 78852 --- [           main] org.phoebus.channelfinder.ElasticConfig  : Created index: cf_tags : acknowledged true
2022-09-20 22:40:23.305  INFO 78852 --- [           main] org.phoebus.channelfinder.ElasticConfig  : Created index: cf_properties : acknowledged true
```

And please execute the following rule also

```bash
make mapping.settings
