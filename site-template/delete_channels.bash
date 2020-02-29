#!/usr/bin/env bash
#

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"


. ${SC_TOP}/es_host.cfg


URL_CHANNELS=http://localhost:8080/ChannelFinder/resources/channels


#Create the Index
print_help "DELETE" "SR04C:BPM1:SA:X1"
curl -u cfuser:4321 -X DELETE ${URL_CHANNELS}/SR04C:BPM1:SA:X1

print_help "DELETE" "SR04C:BPM1:SA:Y1"
curl -u cfuser:4321  -X DELETE ${URL_CHANNELS}/SR04C:BPM1:SA:Y1



#Create the Index
print_help "DELETE" "SR04C:BPM2:SA:X1"
curl -u cfuser:4321  -X DELETE ${URL_CHANNELS}/SR04C:BPM2:SA:X1

print_help "DELETE" "SR04C:BPM2:SA:Y1"
curl -u cfuser:4321  -X DELETE ${URL_CHANNELS}/SR04C:BPM2:SA:Y1



print_help "GET" "CHANNELS"
curl -X GET ${URL_CHANNELS}

