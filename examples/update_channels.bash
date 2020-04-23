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
cf_userid=admin
cf_passwd=1234

cf_user=${cf_userid}:${cf_passwd}

filterA="AR"
filterB="SA:X"

for a_chan in  ${list[@]}; do
    print_help "PUT" "$a_chan"
    temp_json=$(mktemp)
    if [[ $a_chan =~ $filterA ]]; then
	domain="AR"
    else
	domain="SR"
    fi
    if [[ $a_chan =~ $filterB ]]; then
	tag="alpha.sys.$domain";
    else
	tag="beta.sys.$domain";
    fi

    C=$(tr -cd 0-9 </dev/urandom | head -c 8)
    
    echo "
    	[
    	    {
    		\"name\": \"$a_chan\",
    		\"owner\": \"cf-channels\"
    		, \"properties\": [
    		  {
    		  \"name\": \"domain\",
                  \"owner\": \"cf-properties\",
                  \"value\": \"$domain\",
                  \"channels\": []
    		  }
        	]
		, \"tags\": [
    		  {
    		  \"name\": \"$tag\",
                  \"owner\": \"cf-tagsx\",
                  \"value\": \"$C\",
                  \"channels\": []
    		  }
        	]
      	    }
    	]
       "   > ${temp_json}
    

    curl -u $cf_user -H 'Content-Type: application/json' -X PUT ${URL} -d @$temp_json
    rm -f $temp_json
    printf "\n"
done

print_help "GET" "SR domain CHANNELS"
curl -X GET ${URL}?domain=SR
printf "\n";


print_help "GET" "AR domain CHANNELS"
curl -X GET ${URL}?domain=AR
printf "\n";



print_help "GET" "ALL CHANNELS"
curl -X GET ${URL}
printf "\n";

