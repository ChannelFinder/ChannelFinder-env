#!/usr/bin/env bash
#
#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Tue Sep 20 22:24:45 PDT 2022
#   version : 0.0.1


declare -g SC_SCRIPT;
declare -g SC_TOP;
declare -g ENV_TOP;

SC_SCRIPT="$(realpath "$0")";
SC_TOP="${SC_SCRIPT%/*}"
ENV_TOP="${SC_TOP}/.."

SITE_TEMPLATE_PATH=$(make -C "${ENV_TOP}" -s print-CF_SITE_TEMPLATE_PATH)
CF_JSON_PATH="${ENV_TOP}/$(make -C "${ENV_TOP}" -s print-CF_SRC_PATH)"
CF_JSON_PATH+="/src/main/resources"
CF_QUERY_SIZE=$(make -C "${ENV_TOP}" -s print-CF_QUERY_SIZE)

# shellcheck disable=SC1090,SC1091
. "${SC_TOP}"/es_host.cfg

function curl_put
{
    local index="$1"; shift;
    local json="$1"; shift;
   
    local json_file="@${CF_JSON_PATH}/${json}"
    
    printf "Creating %s from %s\n" "$index" "$json";
    if [ -x "`which jq`" ]; then 
        curl -s -H 'Content-Type: application/json' -XPUT http://${es_host}:${es_port}/${index} -d ${json_file} | jq
    else 
        curl -s -H 'Content-Type: application/json' -XPUT http://${es_host}:${es_port}/${index} -d ${json_file}
    fi;

    printf ">>> Settings max_result_window of index %s : %s\n" "$index" "$CF_QUERY_SIZE";
    if [ -x "`which jq`" ]; then 
        curl -s -H 'Content-Type: application/json' -XPUT http://${es_host}:${es_port}/${index}/_settings -d '{ "index" : { "max_result_window" : "'"${CF_QUERY_SIZE}"'" }}' | jq 
    else 
        curl -s -H 'Content-Type: application/json' -XPUT http://${es_host}:${es_port}/${index}/_settings -d '{ "index" : { "max_result_window" : "'"${CF_QUERY_SIZE}"'" }}' 
    fi;
}

#Create the Index : cf_tags, cf_properties, and channelfinder

curl_put "cf_tags" "tag_mapping.json"
curl_put "cf_properties" "properties_mapping.json"
curl_put "channelfinder" "channelfinder_mapping.json"

