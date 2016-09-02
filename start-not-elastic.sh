#!/bin/bash

# use this image as a traditional go agent, i.e., not an elastic agent (and not autoregistered)

docker run -e GOCD_SERVER_URL=$GOCD_SERVER_URL --entrypoint /usr/bin/gocd-golang-agent djrice/gocd-golang-agent
