FROM phusion/baseimage

RUN apt-get update
RUN apt-get install wget

# install agent
RUN wget -O /usr/bin/gocd-golang-agent https://bintray.com/gocd-contrib/gocd_golang_goagent/download_file?file_path=goagent%2F1.1%2Fgocd-golang-agent_linux_amd64_1.1
RUN chmod +x /usr/bin/gocd-golang-agent

# install git
RUN apt-get install -y git

# install script that starts agent
COPY dockerfiles/start-agent.sh /
RUN chmod +x /start-agent.sh
ENTRYPOINT ["/start-agent.sh"]
