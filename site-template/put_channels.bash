#!/usr/bin/env bash

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"


. ${SC_TOP}/es_host.cfg


URL_CHANNELS=http://localhost:8080/ChannelFinder/resources/channels



print_help "PUT" "SR04C:BPM1:SA:X1"
curl -u cfuser:4321 -H 'Content-Type: application/json' -X PUT ${URL_CHANNELS} -d'
[
  {
    "name": "SR04C:BPM1:SA:X1",
    "owner": "cf-channels",
    "properties": [],
    "tags": []
  }
]'


print_help "PUT" "SR04C:BPM1:SA:Y1"
curl -u cfuser:4321 -H 'Content-Type: application/json' -X PUT ${URL_CHANNELS} -d'
[
  {
    "name": "SR04C:BPM1:SA:Y1",
    "owner": "cf-channels",
    "properties": [],
    "tags": []
  }
]'




print_help "PUT" "SR04C:BPM2:SA:X1"
curl -u cfuser:4321 -H 'Content-Type: application/json' -X PUT ${URL_CHANNELS} -d'
[
  {
    "name": "SR04C:BPM2:SA:X1",
    "owner": "cf-channels",
    "properties": [],
    "tags": []
  }
]'


print_help "PUT" "SR04C:BPM2:SA:Y1"
curl -u cfuser:4321 -H 'Content-Type: application/json' -X PUT ${URL_CHANNELS} -d'
[
  {
    "name": "SR04C:BPM2:SA:Y1",
    "owner": "cf-channels",
    "properties": [],
    "tags": []
  }
]'


print_help "GET" "CHANNELS"
curl -X GET ${URL_CHANNELS}



