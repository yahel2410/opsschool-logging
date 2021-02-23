#!/bin/bash
set -e

echo "INFO: userdata started"

# elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-7.10.2-amd64.deb
dpkg -i elasticsearch-*.deb
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


sudo mv /etc/filebeat/filebeat.yml /etc/filebeat/filebeat.yml.BCK

cat <<\EOF > /etc/filebeat/filebeat.yml
filebeat.inputs:
  - type: log
    enabled: false
    paths:
      - /var/log/auth.log

filebeat.modules:
  - module: system
    syslog:
      enabled: false
    auth:
      enabled: false

filebeat.config.modules:
  path: ${path.config}/modules.d/*.yml
  reload.enabled: false

setup.dashboards.enabled: false

setup.template.name: "filebeat"
setup.template.pattern: "filebeat-*"
setup.template.settings:
  index.number_of_shards: 1

processors:
  - add_host_metadata:
      when.not.contains.tags: forwarded
  - add_cloud_metadata: ~

output.elasticsearch:
  hosts: [ "localhost:9200" ]
  index: "filebeat-%{[agent.version]}-%{+yyyy.MM.dd}"
## OR
#output.logstash:
#  hosts: [ "127.0.0.1:5044" ]
EOF

echo "INFO: userdata finished"