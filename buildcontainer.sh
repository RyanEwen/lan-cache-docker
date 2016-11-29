#!/bin/bash

docker build -t cache .

cd sniproxy
docker build -t sniproxy .
