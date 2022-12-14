#!/bin/bash

SCRIPT_NAME="$BASH_SOURCE"
dir=$1
if [ -z "$dir" ]; then
    echo "Usage: $SCRIPT_NAME directory"
    exit 1
fi

if [ ! -d "$dir" ]; then
    echo "$dir is not a directory"
    exit 1
fi

cd $dir

newline='
'
read_val() {
    while true
    do
        eval "read $2 -p \"input $1:$newline\" val"
        if [ -z "$val" ]; then
            echo "$1 cannot be empty" >&2
        else
            echo $val
            exit
        fi
    done
}

env=
dirname=${PWD##*/}
env_file=${DOCKER_VOLUMES}/$dirname/.env
if [ -f $env_file ]; then
    while IFS='=' read -r key val
    do
        if [[ $key != \#* ]]; then # ignore those values starting with #
            key=$(echo $key | tr '.' '_')
            env+="${key%% *}=$val "
        fi
    done < "$env_file"
fi
if [ -f prompt_env_vars ]; then
    vars=()
    while IFS= read -r line; do
        vars+=("$line")
    done < prompt_env_vars
    for key in "${vars[@]}"
    do
        val=$(read_val $key)
        env+="${key%% *}=$val "
    done
fi

docker-compose rm -fs

eval "$env docker-compose up --remove-orphans --build -d"

