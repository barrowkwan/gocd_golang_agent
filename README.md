# A simple demo of elastic docker agents with GoCD

In this demo, I build a Docker image that utilizes the experimental golang agent (https://github.com/gocd-contrib/gocd-golang-agent) and can be used with the GoCD docker elastic agents plugin.

## Install GoCD server, version 16.9 or greater

https://www.go.cd/download/

## Install Docker elastic agents plugin

* Grab latest jar from https://github.com/gocd-contrib/docker-elastic-agents/releases
* Copy jar file into GO_INSTALL_DIR/plugins/external/
* Restart GoCD server

## Configure plugins

* In top menu, navigate to Admin > Plugins
* Click on settings icon to left of "Docker Elatic Agent Plugin"
* Enter the following values
 * Go Server URL (don't use localhost) >> https://IP_ADDRESS:8154/go
 * Agent auto-register Timeout >> 3
 * Maximum docker containers >> 5
 * Docker URI: >> unix:///var/run/docker.sock

## build docker image

You can read more about what's needed for a Docker image to work as a GoCD elastic agent in the README for the elastic agent plugin at https://github.com/gocd-contrib/docker-elastic-agents.

But if you want to quickly understand what's happening here, this docker image:
* Installs gocd-golang-agent at /usr/bin/
* Installs git
* Translates env vars passed by the elastic agents plugin to ones that gocd-golang-agent understands (see dockerfiles/start-agent.sh)

So build the agent and you're ready to go

    ./build.sh

## Configure GoCD to run a test pipeline

* Add an agent auto-register key to the server element of the config XML:

    `<server ... agentAutoRegisterKey="1234567890abcde" ... />`

* Add test pipeline configuration. Embed the below XML inside the `<pipelines>` element
~~~~
     <pipeline name="ls-elastic">
      <materials>
        <git url="https://github.com/djrice/trigger.git" />
      </materials>
      <stage name="defaultStage">
        <jobs>
          <job name="ls">
            <tasks>
              <exec command="ls" />
            </tasks>
            <agentConfig pluginId="cd.go.contrib.elastic-agent.docker">
              <property>
                <key>Image</key>
                <value>djrice/gocd-golang-agent</value>
              </property>
            </agentConfig>
          </job>
        </jobs>
      </stage>
    </pipeline>
~~~~

## Trigger the pipeline

Unpause the pipeline and give it a run.  You can look at the agents tab and the output of "docker ps" to see what's happening.

## For use as a not-elastic agent

If you wanted to use this docker image as a non-elastic go agent, you can simply do this:

    GOCD_SERVER_URL=https://w.x.y.z:8154/go ./start-not-elastic
