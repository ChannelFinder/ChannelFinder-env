#!/usr/bin/env bash
#
#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Thursday, February 20 14:38:29 PST 2020
#   version : 0.0.1


declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"

. ${SC_TOP}/es_host.cfg


curl -XDELETE http://${es_host}:${es_port}/cf_tags
echo ""
curl -XDELETE http://${es_host}:${es_port}/channelfinder
echo ""
curl -XDELETE http://${es_host}:${es_port}/cf_properties
echo ""
