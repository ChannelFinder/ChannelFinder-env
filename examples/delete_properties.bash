#!/usr/bin/env bash

declare -g SC_SCRIPT;
declare -g SC_TOP;

SC_SCRIPT="$(realpath "$0")";
SC_TOP="${SC_SCRIPT%/*}"


# shellcheck disable=SC1090,SC1091
. "${SC_TOP}"/configuration.bash

list=$(get_list_from_a_file "${SC_TOP}"/PROPERTIES)

# shellcheck disable=SC2154
URL="${cf_url}"/properties

# admin, cfuser, property
# username, and its password should be matched with the running ldif file.
# 
cf_userid=property
cf_passwd=1234
cf_user="${cf_userid}:${cf_passwd}"

for a_property in  "${list[@]}"; do
    print_help "DELETE" "$a_property"
    curl -u $cf_user -X DELETE "${URL}/${a_property}"
    printf "\n"
done

print_help "GET" "Properties"
curl -X GET "${URL}"
printf "\n";

