#!/usr/bin/env bash
#
#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Wed Sep 21 11:12:34 PDT 2022
#   version : 0.0.1


declare -g SC_SCRIPT;
declare -g SC_TOP;
declare -g ENV_TOP;

SC_SCRIPT="$(realpath "$0")";
SC_TOP="${SC_SCRIPT%/*}"
ENV_TOP="${SC_TOP}/.."

CF_JSON_PATH="${ENV_TOP}/$(make -C "${ENV_TOP}" -s print-CF_SRC_PATH)"
CF_JSON_PATH+="/src/main/resources"
CF_QUERY_SIZE=$(make -C "${ENV_TOP}" -s print-CF_QUERY_SIZE)

# shellcheck disable=SC1090,SC1091
. "${SC_TOP}"/es_host.cfg

function curl_put
{
    local index="$1"; shift;
    local json="$1"; shift;
   
    local json_file="${CF_JSON_PATH}/${json}"

    if [ ! -f "$json_file" ]; then
        printf "Warning::File not found %s\n" "$json_file";
        printf "Please check %s\n" "$json_file";
        exit;
    fi
    
    printf ">>> Creating ...%s... from ...%s...\n" "$index" "$json";
    if [ -x "$(which jq)" ]; then
    # shellcheck disable=SC2154
        curl -s -H 'Content-Type: application/json' -XPUT http://"${es_host}:${es_port}/${index}" -d "@${json_file}" | jq
    else 
    # shellcheck disable=SC2154
        curl -s -H 'Content-Type: application/json' -XPUT http://"${es_host}:${es_port}/${index}" -d "@${json_file}"
    fi;
    printf ">>>\n"

    printf ">>> Settings max_result_window of index ...%s... : ...%s...\n" "$index" "$CF_QUERY_SIZE";
    if [ -x "$(which jq)" ]; then 
    # shellcheck disable=SC2154
        curl -s -H 'Content-Type: application/json' -XPUT http://"${es_host}:${es_port}/${index}"/_settings -d '{ "index" : { "max_result_window" : "'"${CF_QUERY_SIZE}"'" }}' | jq 
    else 
    # shellcheck disable=SC2154
        curl -s -H 'Content-Type: application/json' -XPUT http://"${es_host}:${es_port}/${index}"/_settings -d '{ "index" : { "max_result_window" : "'"${CF_QUERY_SIZE}"'" }}' 
    fi;
    printf ">------------\n";

}

function curl_get
{
    local index="$1"; shift;
    local meta="$1"; shift;
   
    printf ">>> Checking ...%s... with ...%s...\n" "$index" "$meta";
    if [ -x "$(which jq)" ]; then
    # shellcheck disable=SC2154
        curl -s -XGET http://"${es_host}:${es_port}/${index}/_${meta}"  | jq
    else 
    # shellcheck disable=SC2154
        curl -s -XGET http://"${es_host}:${es_port}/${index}/_${meta}"
    fi;
    printf ">----------\n";
}

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


function IndexMapping
{
    local index="$1"; shift;
    local json="$1"; shift;
    curl_put "$index" "$json"
    curl_get "$index" "mapping"
}

function MetaSearching
{
    local meta="$1"; shift;
    curl_get "cf_tags" "$meta"
    curl_get "cf_properties" "$meta"
    curl_get "channelfinder" "$meta"
}


function usage
{
    {
        echo "";
        echo "Usage    : $0  args"
        echo "";
        echo "              possbile args";
        echo "";
        echo "              mapping            : CF index mapping";
        echo "              mappingClean       : Delete all CF index";
        echo "              mappingVerify      : Verify the existing mappings";
        echo "              metaField 'search' : mapping, search, .... ";
        echo "              h                  : this screen";
        echo "";
        echo " bash $0 mapping "
        echo ""
    } 1>&2;
    exit 1;
}



case "$1" in
    mapping)
        IndexMapping "channelfinder" "channel_mapping.json"
        IndexMapping "cf_tags"       "tag_mapping.json"
        IndexMapping "cf_properties" "properties_mapping.json"
	    ;;
    mappingClean)
        curl_delete "cf_tags"
        curl_delete "cf_properties"
        curl_delete "channelfinder"
	    ;;
    mappingVerify)
        curl_get "cf_tags" "mapping"
        curl_get "cf_properties" "mapping"
        curl_get "channelfinder" "mapping"
        ;;
    metaField)
        MetaSearching "$2"
        ;;
    h);;
    help)
        usage;
        ;;
    *)
	    usage;
    ;;
esac

