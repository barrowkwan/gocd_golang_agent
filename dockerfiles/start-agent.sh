#!/bin/bash

AGENTKEY=`echo "$AUTO_REGISTER_CONTENTS" | grep -C 0 "agent.auto.register.key" | cut -d "=" -f 2`
GOCD_AGENT_AUTO_REGISTER_KEY=$AGENTKEY GOCD_SERVER_URL=$GO_SERVER_URL /usr/bin/gocd-golang-agent
