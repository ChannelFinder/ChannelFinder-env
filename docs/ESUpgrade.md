# New Elasticsearch configuration

The following error tells us we have old elasticsearch configuration exists.

```bash
[2022-09-27T11:22:59,729][ERROR][o.e.b.Bootstrap          ] [als-es-node] Exception
java.lang.IllegalArgumentException: Could not load codec 'Lucene92'. Did you forget to add lucene-backward-codecs.jar?
```

* Solution

We have to remove all existing file in `CF_ES_DATA_PATH`. For Debian, it is `/var/lib/elasticsearc` 

```bash
rm -rf /var/lib/elasticsearch
mkdir -p /var/lib/elasticsearch
chown elasticsearch:elasticsearch /var/lib/elasticsearch
systemctl restart elasticsearch
```


