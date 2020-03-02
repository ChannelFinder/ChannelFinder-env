#!/usr/bin/env bash
declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"

. ${SC_TOP}/configuration.bash

list="$(get_list_from_a_file ${SC_TOP}/PROPERTIES)"

#cf_url=https://${cf_host}:8443/ChannelFinder/resources
URL=${cf_url}/properties


# admin, cfuser, property
# username, and its password should be matched with the running ldif file.
#
cf_userid=admin
cf_passwd=1234
cf_user=${cf_userid}:${cf_passwd}

temp_json=$(mktemp)

for a_property in  ${list[@]}; do
    print_help "PUT" "$a_property"
    temp_json=$(mktemp)
    echo "
    	[
	    {
		\"name\": \"$a_property\",
		\"owner\": \"cf-properties\"
	    }
	]
       " > ${temp_json}

    curl -u $cf_user -H 'Content-Type: application/json' -X PUT ${URL} -d @$temp_json
    rm -f $temp_json
    printf "\n"
done

print_help "GET" "Properties"
curl -X GET ${URL}
printf "\n";



