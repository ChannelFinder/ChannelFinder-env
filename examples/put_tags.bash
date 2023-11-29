#!/usr/bin/env bash


declare -g SC_SCRIPT;
declare -g SC_TOP;

SC_SCRIPT="$(realpath "$0")";
SC_TOP="${SC_SCRIPT%/*}"


# shellcheck disable=SC1090,SC1091
. "${SC_TOP}"/configuration.bash


list=$(get_list_from_a_file"${SC_TOP}"/TAGS)

#cf_url=https://${cf_host}:8443/ChannelFinder/resources
# shellcheck disable=SC2154
URL="${cf_url}"/tags


# admin, cfuser, tag, operator
# username, and its password should be matched with the running ldif file.
# 
cf_userid="admin"
cf_passwd=1234
cf_user="${cf_userid}:${cf_passwd}"

temp_json=$(mktemp)

#a_chan="SR04C:BPM1:SA:X1"

for a_tag in  "${list[@]}"; do
    print_help "PUT" "$a_tag"
    temp_json=$(mktemp)
    echo "
    	[
	    {
		\"name\": \"$a_tag\",
		\"owner\": \"cf-tags\"
	    }
	]
       " > "${temp_json}"

    curl -u "$cf_user" -H 'Content-Type: application/json' -X PUT "${URL}" -d @"$temp_json"
    rm -f "$temp_json"
    printf "\n"
done

print_help "GET" "tags"
curl -X GET "${URL}"
printf "\n";
