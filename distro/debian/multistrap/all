#!/bin/bash

source config.sh
source setup-env.sh
./check-deps.sh &&
./install-packages.sh &&
./setup-dpkg-config.sh &&
./create-nodes.sh &&
./setup-etc.sh
./cleanup.sh 
