A simple example
===

This example may help users to understand the relations among channels, properties, and tags. All channels, properties, and tags are not designed carefully, so that one should not use this kind of combinations in a real Channel Finder configuration. 


## Create tags, properties, and channels

Fake channel name, property name, and tag name are defined in `CHANNELS`, `PROPERTIES`, and `TAGS`. We use them to show this example.

```
bash put_channels.bash
bash put_properties.bash
bash put_tags.bash
```
One should check the following urls by using a REST client. I recommend insomnia [1] 

```
http://localhost:8080/ChannelFinder/resources/channels
http://localhost:8080/ChannelFinder/resources/properties
http://localhost:8080/ChannelFinder/resources/tags
```


## Update channels according to the properties, and tags which we defined. 

```
bash update_channels.bash
```

### Few output results



```
GET http://localhost:8080/ChannelFinder/resources/properties/domain

{
  "name": "domain",
  "owner": "cf-properties",
  "value": null,
  "channels": [
    {
      "name": "AR04C:BPM1:SA:X1",
      "owner": "cf-channels",
      "properties": [
        {
          "name": "domain",
          "owner": "cf-properties",
          "value": "AR",
          "channels": []
        }
      ],
      "tags": []
    },
    {
      "name": "AR04C:BPM2:SA:X1",
      "owner": "cf-channels",
      "properties": [
        {
          "name": "domain",
          "owner": "cf-properties",
          "value": "AR",
          "channels": []
        }
      ],
      "tags": []
    },
    {
      "name": "SR04C:BPM1:SA:X1",
      "owner": "cf-channels",
      "properties": [
        {
          "name": "domain",
          "owner": "cf-properties",
          "value": "SR",
          "channels": []
        }
      ],
      "tags": []
    },
    {
      "name": "SR04C:BPM2:SA:X1",
      "owner": "cf-channels",
      "properties": [
        {
          "name": "domain",
          "owner": "cf-properties",
          "value": "SR",
          "channels": []
        }
      ],
      "tags": []
    }
  ]
}

GET http://localhost:8080/ChannelFinder/resources/tags/alpha.sys.SR

{
  "name": "alpha.sys.SR",
  "owner": "cf-tags",
  "channels": [
    {
      "name": "SR04C:BPM1:SA:X1",
      "owner": "cf-channels",
      "properties": [],
      "tags": []
    },
    {
      "name": "SR04C:BPM2:SA:X1",
      "owner": "cf-channels",
      "properties": [],
      "tags": []
    }
  ]
}

```


```
GET http://localhost:8080/ChannelFinder/resources/channels?~name=*BPM1*&domain=SR

[
  {
    "name": "SR04C:BPM1:SA:X1",
    "owner": "cf-channels",
    "properties": [
      {
        "name": "domain",
        "owner": "cf-properties",
        "value": "SR",
        "channels": []
      }
    ],
    "tags": [
      {
        "name": "alpha.sys.SR",
        "owner": "cf-tags",
        "channels": []
      }
    ]
  }
]
```

* GET the `alpha.sys.SR` tag

```
GET http://localhost:8080/ChannelFinder/resources/tags/alpha.sys.SR


{
  "name": "alpha.sys.SR",
  "owner": "cf-tags",
  "channels": [
    {
      "name": "SR04C:BPM1:SA:X1",
      "owner": "cf-channels",
      "properties": [],
      "tags": []
    },
    {
      "name": "SR04C:BPM2:SA:X1",
      "owner": "cf-channels",
      "properties": [],
      "tags": []
    }
  ]
}
```

* DELETE the `alpha.sys.SR` tag

```
DELETE http://localhost:8080/ChannelFinder/resources/tags/alpha.sys.SR/SR04C:BPM2:SA:X1
```

* GET the `alpha.sys.SR` tag

```
GET http://localhost:8080/ChannelFinder/resources/tags/alpha.sys.SR


{
  "name": "alpha.sys.SR",
  "owner": "cf-tags",
  "channels": [
    {
      "name": "SR04C:BPM1:SA:X1",
      "owner": "cf-channels",
      "properties": [],
      "tags": []
    }
  ]
}
```


## Permission

`DELETE` needs a proper permission, it relates with `owner` and `group` within the embedded LDAP configuration. Please see `ldif` file for further information.


## Reference
[1] https://insomnia.rest/

