#!/bin/bash 

date

elasticsearch-${EK_VERSION}/bin/elasticsearch -E http.host=0.0.0.0 -d
nohup kibana-${EK_VERSION}-linux-x86_64/bin/kibana --allow-root --host 0.0.0.0 -Q &

sudo metricbeat modules enable docker

sudo cp docker.yml /etc/metricbeat/modules.d/docker.yml

sudo service metricbeat start

sleep 60

sudo metricbeat setup

sudo service filebeat start
sudo filebeat setup

sudo service apm-server start
sudo apm-server setup

date

echo ELK and APM server are ready

sleep infinity

