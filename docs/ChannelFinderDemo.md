# Built-in Demo Testing

## Run Demo

This demo is not available within the systemd service. Thus, please use it without systemd services. 

One should follow the strict order to run a channelfinder built-in demo service if the channelfinder runs locally, i.e., no systemd service.

* Check the system is not running now.

```bash
systemctl status channelfinder.service
systemctl stop channelfinder.service
systemctl disable channelfinder.service
```

* One should be in the `ChannelFinder-env`

```
make run
make mapping
make demo
```

## Check the Demo service

If one doesn't have `jq`, it is highly recommended to install it. For example, `apt install jq` in Debian system.

```
curl -s http://localhost:8080/ChannelFinder/resources/tags       | jq
curl -s http://localhost:8080/ChannelFinder/resources/properties | jq
curl -s http://localhost:8080/ChannelFinder/resources/channels   | jq
```

## Check, Add, and Remove a tag


```bash
$ curl -s --request GET http://localhost:8080/ChannelFinder/resources/tags/foo
{"name":"foo","owner":"admin","channels":[]}

$ curl -s -u admin:1234 -H 'Content-Type: application/json' --request PUT http://localhost:8080/ChannelFinder/resources/tags/foo -d '{"name":"foo", "owner":"admin"}'
{"name":"foo","owner":"admin","channels":[]}

$ curl -s --request GET http://localhost:8080/ChannelFinder/resources/tags/foo
{"name":"foo","owner":"admin","channels":[]}

$curl --basic -u admin:1234 -X DELETE   http://localhost:8080/ChannelFinder/resources/tags/foo
$ curl -s --request GET http://localhost:8080/ChannelFinder/resources/tags/foo
{"timestamp":"2022-09-21T21:35:46.677+00:00","status":404,"error":"Not Found","path":"/ChannelFinder/resources/tags/foo"}
```

One can see not very kind log messages, which cannot tell exactly what kind of performance they did, in ChannelFinder log as follows:

```bash
2022-09-21 14:24:05.289  INFO 96837 --- [nio-8080-exec-1] o.p.channelfinder.TagManager.audit       : getting tag: foo
2022-09-21 14:24:05.325  INFO 96837 --- [nio-8080-exec-1] org.phoebus.channelfinder.TagRepository  : Tag name foo
2022-09-21 14:34:45.959  INFO 96837 --- [nio-8080-exec-9] o.p.channelfinder.TagManager.audit       : getting tag: foo
2022-09-21 14:34:45.980  INFO 96837 --- [nio-8080-exec-9] org.phoebus.channelfinder.TagRepository  : Tag name foo
2022-09-21 14:35:10.958  INFO 96837 --- [nio-8080-exec-1] o.p.channelfinder.TagManager.audit       : client initialization: 0
2022-09-21 14:35:10.979  INFO 96837 --- [nio-8080-exec-1] org.phoebus.channelfinder.TagRepository  : Tag name foo
2022-09-21 14:35:11.182  INFO 96837 --- [nio-8080-exec-1] org.phoebus.channelfinder.TagRepository  : Tag name foo
2022-09-21 14:35:23.583  INFO 96837 --- [nio-8080-exec-2] o.p.channelfinder.TagManager.audit       : getting tag: foo
2022-09-21 14:35:23.594  INFO 96837 --- [nio-8080-exec-2] org.phoebus.channelfinder.TagRepository  : Tag name foo
2022-09-21 14:35:37.897  INFO 96837 --- [nio-8080-exec-4] org.phoebus.channelfinder.TagRepository  : Tag name foo
2022-09-21 14:35:46.649  INFO 96837 --- [nio-8080-exec-6] o.p.channelfinder.TagManager.audit       : getting tag: foo
2022-09-21 14:35:46.664  INFO 96837 --- [nio-8080-exec-6] org.phoebus.channelfinder.TagRepository  : Tag not found
2022-09-21 14:35:46.668 ERROR 96837 --- [nio-8080-exec-6] org.phoebus.channelfinder.TagManager     : The tag with the name foo does not exist
```

## `cf_query.bash`

The script makes our life a bit easy to verify the CF server is running correctly.

```bash
$ bash scripts/cf_queries.bash get tags foo
>>> Getting ...tags... with ...foo...
{
  "name": "foo",
  "owner": "admin",
  "channels": []
}
>----------

$ bash scripts/cf_queries.bash delete tags foo
>>> Deleting...tags... with ...foo...
>----------

$ bash scripts/cf_queries.bash get tags foo
>>> Getting ...tags... with ...foo...
{
  "timestamp": "2022-09-21T22:28:08.966+00:00",
  "status": 404,
  "error": "Not Found",
  "path": "/ChannelFinder/resources/tags/foo"
}
>----------

$ bash scripts/cf_queries.bash put tags foo scripts/tag_foo.json
>>> Putting ...... ......
{
  "name": "foo",
  "owner": "admin",
  "channels": []
}
>------------

$ bash scripts/cf_queries.bash get tags foo
>>> Getting ...tags... with ...foo...
{
  "name": "foo",
  "owner": "admin",
  "channels": []
}
>----------
```

