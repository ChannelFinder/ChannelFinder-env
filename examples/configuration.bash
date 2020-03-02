

cf_host=localhost
cf_port=8080
cf_url=http://${cf_host}:${cf_port}/ChannelFinder/resources


function print_help
{
    local a=$1; shift;
    local b=$1; shift;
    printf "\n>>> %s : %s ....\n" "$a" "$b";
}


function get_list_from_a_file
{
    local empty_string="";
    declare -a entry=();
 
    while IFS= read -r line_data; do
	if [ "$line_data" ]; then
	    # Skip command #
	    [[ "$line_data" =~ ^#.*$ ]] && continue
	    entry[i]="${line_data}"
	    ((++i))
	fi
    done < $1
 
    echo ${entry[@]}
}

