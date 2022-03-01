#!/bin/bash
set -e

echo "INFO: userdata started"
export DEBIAN_FRONTEND=noninteractive

# elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-7.10.2-amd64.deb
dpkg -i elasticsearch-*.deb
echo 'network.host: 0.0.0.0' >> /etc/elasticsearch/elasticsearch.yml
echo 'discovery.type: single-node' >> /etc/elasticsearch/elasticsearch.yml
systemctl enable elasticsearch
systemctl start elasticsearch

# kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-oss-7.10.2-amd64.deb
dpkg -i kibana-*.deb
echo 'server.host: "0.0.0.0"' > /etc/kibana/kibana.yml
systemctl enable kibana
systemctl start kibana

# filebeat
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-oss-7.11.0-amd64.deb
dpkg -i filebeat-*.deb

# mysql
apt update
apt install mysql-server -y
systemctl enable mysql
systemctl start mysql

# docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ubuntu

sudo mv /etc/filebeat/filebeat.yml /etc/filebeat/filebeat.yml.BCK

cat <<\EOF > /etc/filebeat/filebeat.yml
filebeat.inputs:
  - type: log
    enabled: false
    paths:
      - /var/log/auth.log

  - type: container
    enabled: false
    paths:
      - "/var/lib/docker/containers/*/*.log"

filebeat.modules:
  - module: system
    syslog:
      enabled: false
    auth:
      enabled: false

  - module: mysql
    error:
      enabled: false
    slowlog:
      enabled: false

filebeat.config.modules:
  path: ${path.config}/modules.d/*.yml
  reload.enabled: false

setup.dashboards.enabled: true

setup.template.name: "filebeat"
setup.template.pattern: "filebeat-*"
setup.template.settings:
  index.number_of_shards: 1

processors:
  - add_host_metadata:
      when.not.contains.tags: forwarded
  - add_cloud_metadata: ~
  - add_docker_metadata:
      host: "unix:///var/run/docker.sock"

output.elasticsearch:
  hosts: [ "localhost:9200" ]
  index: "filebeat-%{[agent.version]}-%{+yyyy.MM.dd}"
## OR
#output.logstash:
#  hosts: [ "127.0.0.1:5044" ]
EOF

echo "INFO: userdata finished"