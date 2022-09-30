#!/bin/bash -xe

declare -r SCRIPT_NAME=$(basename "$BASH_SOURCE" .sh)

## exit the shell(default status code: 1) after printing the message to stderr
bail() {
    echo -ne "$1" >&2
    exit ${2-1}
} 

## help message
declare -r HELP_MSG="Usage: $SCRIPT_NAME [-H host] [-p port] username password backup-tar-path
  -h       display this help and exit
  -H       mysql host
  -p       mysql port
"

## print the usage and exit the shell(default status code: 2)
usage() {
    declare status=2
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        status=$1
        shift
    fi
    bail "${1}$HELP_MSG" $status
}

HOST=redmine_mysql
PORT=3306
while getopts ":d:hH:i:" opt; do
    case $opt in
        h)
            usage 0
            ;;
        H)
            HOST=${OPTARG}
            ;;
        p)
            PORT=${OPTARG}
            ;;
        \?)
            usage "Invalid option: -$OPTARG \n"
            ;;
    esac
done

shift $(($OPTIND - 1))

#==========MAIN CODE BELOW==========

[ "$#" -lt 3 ] && usage

readonly USER="$1"
readonly PASSWORD="$2"
readonly DEST_FILE="$3"

set -o pipefail
mysqldump -h ${HOST-localhost} -P ${PORT} -u $USER -p$PASSWORD --all-databases | gzip > $DEST_FILE
