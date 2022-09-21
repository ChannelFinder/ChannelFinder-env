# ChannelFinder Configuration

## Create Indexes and add mapping information

We have three indexes such as

```bash
channelfinder
cf_tags
cf_properties
```

This can be created via `make mapping` or set `elasticsearch.create.indices: true` in `applicaton.properties`

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
```


* After `make build` [Default]

```bash
make mapping
```

Please check `create_indexes.bash` file in `site-template` for further information.

* Index will be deleted via `make mapping.clean`


