#!/usr/bin/env bash
#
#  author  : Jeong Han Lee
#  email   : jeonghan.lee@gmail.com
#  date    : Saturday, June 27 18:03:37 PDT 2020
#  version : 0.0.1



JAR=$(find /opt/channelfinder/ -name "ChannelFinder*.jar")

options="o:"

while getopts "${options}" opt; do
    case "${opt}" in
        o) JAVA_OPTS=${OPTARG}      ;;
   	:)
	    echo "Option -$OPTARG requires an argument." >&2
	    usage
	    ;;
	h)
	    usage
	    ;;
	\?)
	    echo "Invalid option: -$OPTARG" >&2
	    usage
	    ;;
    esac
done
shift $((OPTIND-1))


# Debian, openjdk is located in /usr/bin/
#
command="/usr/bin/java ${JAVA_OPTS} -jar $JAR "$@""
exec $command
