# NOT currently working as elastic agent...

The problem seems to be with my bash scripting. To start debugging
* look at ENTRYPOINT in Dockerfil
* look at contents of dockerfiles/start-agent.sh

# For use with docker elastic agents

## build image

    ./build.sh
  
## configure GoCD

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

# For use as a not-elastic agent

    GOCD_SERVER_URL=https://w.x.y.z:8154/go ./start-not-elastic
