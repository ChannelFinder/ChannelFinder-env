#!/usr/bin/env bash
#
#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Tue Sep 20 22:24:45 PDT 2022
#   version : 0.0.1

declare -g SC_SCRIPT;
declare -g SC_TOP;

SC_SCRIPT="$(realpath "$0")";
SC_TOP="${SC_SCRIPT%/*}"

# shellcheck disable=SC1090,SC1091
. "${SC_TOP}"/es_host.cfg


function curl_delete
{
    local index="$1"; shift;
   
    printf "Deleting %s \n" "$index";
    if [ -x "$(which jq)" ]; then 
    # shellcheck disable=SC2154
        curl -s -XDELETE http://"${es_host}:${es_port}/${index}" | jq
    else 
    # shellcheck disable=SC2154
        curl -s -XDELETE http://"${es_host}:${es_port}/${index}" 
    fi;
}

#Create the Index : cf_tags, cf_properties, and channelfinder

curl_delete "cf_tags"
curl_delete "cf_properties"
curl_delete "channelfinder"

