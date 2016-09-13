#!/bin/bash

AGENTKEY=`echo "$AUTO_REGISTER_CONTENTS" | grep -C 0 "agent.auto.register.key" | cut -d "=" -f 2`
EA_AGENT_ID=`echo "$AUTO_REGISTER_CONTENTS" | grep -C 0 "agent.auto.register.elasticAgent.agentId" | cut -d "=" -f 2`
EA_PLUGIN_ID=`echo "$AUTO_REGISTER_CONTENTS" | grep -C 0 "agent.auto.register.elasticAgent.pluginId" | cut -d "=" -f 2`
GOCD_AGENT_AUTO_REGISTER_KEY=$AGENTKEY GOCD_SERVER_URL=$GO_SERVER_URL GOCD_AGENT_AUTO_REGISTER_ELASTIC_AGENT_ID=$EA_AGENT_ID GOCD_AGENT_AUTO_REGISTER_ELASTIC_PLUGIN_ID=$EA_PLUGIN_ID /usr/bin/gocd-golang-agent
