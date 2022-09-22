#!/usr/bin/env bash
#
#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Wed Sep 21 11:12:34 PDT 2022
#   version : 0.0.1


declare -g SC_SCRIPT;
declare -g SC_TOP;
declare -g ENV_TOP;
declare -g CF_URL;
declare -g ADMIN;

SC_SCRIPT="$(realpath "$0")";
SC_TOP="${SC_SCRIPT%/*}"
ENV_TOP="${SC_TOP}/.."

# shellcheck disable=SC2154
CF_URL="$(make -s -C "${ENV_TOP}" print-CF_FULL_URL)/resources";

ADMIN="admin:1234"

function cf_put
{
    local arg1="$1"; shift;
    local arg2="$1"; shift;
    local arg3="$1"; shift;
    
    printf ">>> Putting ...%s... ...%s...\n" "$arg1" "$arg2";
    if [ -x "$(which jq)" ]; then
        curl -s -H 'Content-Type: application/json' -u "${ADMIN}" --request PUT "${CF_URL}/${arg1}/${arg2}" -d "@${arg3}" | jq
    else 
        curl -s -H 'Content-Type: application/json' -u "${ADMIN}" --request PUT "${CF_URL}/${arg1}/${arg2}" -d "@${arg3}"
    fi;
    printf ">------------\n";

}

function cf_get
{
    local arg1="$1"; shift;
    local arg2="$1"; shift;
   
    printf ">>> Getting ...%s... with ...%s...\n" "$arg1" "$arg2";
    if [ -x "$(which jq)" ]; then
#        echo "curl -s --request GET "${CF_URL}/${arg1}/${arg2}"  | jq"
        curl -s --request GET "${CF_URL}/${arg1}/${arg2}"  | jq
    else 
        curl -s -XGET "${CF_URL}/${arg1}/${arg2}"
    fi;
    printf ">----------\n";
}

function cf_delete
{
    local arg1="$1"; shift;
    local arg2="$1"; shift;
   
    printf ">>> Deleting...%s... with ...%s...\n" "$arg1" "$arg2";
    if [ -x "$(which jq)" ]; then 
        curl --basic -u "${ADMIN}" -s --request DELETE "${CF_URL}/${arg1}/${arg2}" | jq
    else 
        curl --basic -u "${ADMIN}" -s --request DELETE "${CF_URL}/${arg1}/${arg2}"
    fi;
    printf ">----------\n"
}


function usage
{
    {
        echo "";
        echo "Usage    : $0  args"
        echo "";
        echo "              possbile args";
        echo "";
        echo "              get    arg1 arg2      : Get ";
        echo "              delete arg1 arg2      : Delete ";
        echo "              put    arg1 arg2 arg3 : Put, arg3 is a json file";
        echo "              h                  : this screen";
        echo "";
        echo " bash $0 mapping "
        echo ""
    } 1>&2;
    exit 1;
}

arg0="$1"; shift;
arg1="$1"; shift;
arg2="$1"; shift;
arg3="$1"; shift;

case "$arg0" in
    get)
        cf_get "$arg1" "$arg2"
        ;;
    delete)
        cf_delete "$arg1" "$arg2"
        ;;
    put)
        cf_put "$arg1" "$arg2" "$arg3"
        ;;
    h);;
    help)
        usage;
        ;;
    *)
	    usage;
    ;;
esac

