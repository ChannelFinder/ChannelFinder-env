#!/usr/bin/env bash
#
#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Thursday, February 20 14:38:29 PST 2020
#   version : 0.0.1


declare -g SC_SCRIPT;
declare -g SC_TOP;

SC_SCRIPT="$(realpath "$0")";
SC_TOP="${SC_SCRIPT%/*}"

# shellcheck disable=SC1090,SC1091
. "${SC_TOP}"/es_host.cfg


# shellcheck disable=SC2153,SC2154
ES_URL="http://${es_host}:${es_port}"


curl -XDELETE "${ES_URL}"/cf_tags
echo ""
curl -XDELETE "${ES_URL}"/channelfinder
echo ""
curl -XDELETE "${ES_URL}"/cf_properties
echo ""
