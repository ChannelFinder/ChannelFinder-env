#!/usr/bin/env bash

declare -g SC_SCRIPT;
declare -g SC_TOP;

SC_SCRIPT="$(realpath "$0")";
SC_TOP="${SC_SCRIPT%/*}"

# shellcheck disable=SC1090,SC1091
. "${SC_TOP}/configuration.bash"


list=$(get_list_from_a_file "${SC_TOP}"/CHANNELS)

# shellcheck disable=SC2154
URL="${cf_url}"/channels

# admin, cfuser, channel
# username, and its password should be matched with the running ldif file.
#
cf_userid=channel
cf_passwd=1234
cf_user="${cf_userid}:${cf_passwd}"


for a_chan in  "${list[@]}"; do
    print_help "DELETE" "$a_chan"
    curl -u $cf_user -X DELETE "${URL}/${a_chan}"
    printf "\n"
done

print_help "GET" "CHANNELS"
curl -X GET "${URL}"
printf "\n";

