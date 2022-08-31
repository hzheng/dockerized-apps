#!/bin/bash

cd $1

docker-compose rm -fs

docker-compose up --remove-orphan --build -d

