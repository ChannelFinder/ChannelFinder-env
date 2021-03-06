#!/usr/bin/env bash

###
# #%L
# ChannelFinder Directory Service
# %%
# Copyright (C) 2010 - 2016 Helmholtz-Zentrum Berlin für Materialien und Energie GmbH
# %%
# Copyright (C) 2010 - 2012 Brookhaven National Laboratory
# All rights reserved. Use is subject to license terms.
# %%
# Copyright (c) 2020        Jeong Han Lee
# #L%
###
# The mapping definition for the Indexes associated with the channelfinder v4

#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Wednesday, April 22 23:00:18 PDT 2020
#   version : 0.0.2

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"


. ${SC_TOP}/es_host.cfg


#Create the Index : three
print_help "index" "cf_tags"
curl -XPUT http://${es_host}:${es_port}/cf_tags
print_help "index" "cf_properties"
curl -XPUT http://${es_host}:${es_port}/cf_properties
print_help "index" "channelfinder"
curl -XPUT http://${es_host}:${es_port}/channelfinder

print_help "mapping" "cf_tags"
curl -H 'Content-Type: application/json' -XPUT http://${es_host}:${es_port}/cf_tags/_mapping/cf_tag?include_type_name=true -d'
{
  "cf_tag" : {
    "properties" : {
      "name"  : { "type" : "keyword" },
      "owner" : { "type" : "keyword" }
    }
  }
}'

print_help "mapping" "cf_properties"
curl -H 'Content-Type: application/json' -XPUT http://${es_host}:${es_port}/cf_properties/_mapping/cf_property?include_type_name=true -d'
{
  "cf_property" : {
    "properties" : {
      "name"  : { "type" : "keyword" },
      "owner" : { "type" : "keyword" }
    }
  }
}'

print_help "mapping" "channelfinder"
curl -H 'Content-Type: application/json' -XPUT http://${es_host}:${es_port}/channelfinder/_mapping/cf_channel?include_type_name=true -d'
{
  "cf_channel" : {
    "properties" : {
	"name"   : { "type" : "keyword" },
	"owner"  : { "type" : "keyword" },
	"script" : { "type" : "keyword" },
	"cf_properties" : {
            "type" : "nested",
	    "include_in_parent" : true,
            "properties" : {
		"name"  : { "type" : "keyword" },
		"owner" : { "type" : "keyword" },
		"value" : { "type" : "keyword" }
            }
	},
	"cf_tags" : {
            "type" : "nested",
	    "include_in_parent" : true,
            "properties" : {
		"name"  : { "type" : "keyword" },
		"owner" : { "type" : "keyword" }
            }
	}
    }
  }
}'

printf "\n";
