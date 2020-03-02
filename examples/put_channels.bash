#!/usr/bin/env bash

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"

. ${SC_TOP}/configuration.bash

list="$(get_list_from_a_file ${SC_TOP}/CHANNELS)"

URL=${cf_url}/channels


# admin, cfuser, channel
# username, and its password should be matched with the running ldif file.
#
cf_userid=channel
cf_passwd=1234
cf_user=${cf_userid}:${cf_passwd}

for a_chan in  ${list[@]}; do
    print_help "PUT" "$a_chan"
    temp_json=$(mktemp)
    echo "
   	[
	    {
		\"name\": \"$a_chan\",
		\"owner\": \"cf-channels\"
	    }
	]
    " > ${temp_json}
    #echo "
    # 	[
    # 	    {
    # 		\"name\": \"$a_chan\",
    # 		\"owner\": \"cf-channels\"
    # 		, \"properties\": [
    # 		  {
    # 		  \"name\": \"elementPosX\",
    #               \"owner\": \"cf-properties\",
    #               \"value\": \"12.45\",
    #               \"channels\": []
    # 		  }
    #     	]
    # 		, \"tags\": [
    #         	  {
    #               \"name\": \"alpha.sys.SR\",
    #               \"owner\": \"cf-tags\",
    #               \"channels\": []
    # 		  }
    #     	]
    # 	    }
    # 	]
    #    "   > ${temp_json}
    

    curl -u $cf_user -H 'Content-Type: application/json' -X PUT ${URL} -d @$temp_json
    rm -f $temp_json
    printf "\n"
done

print_help "GET" "CHANNELS"
curl -X GET ${URL}
printf "\n";

