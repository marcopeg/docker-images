FROM openjdk:11.0.11-jre-slim

ENV EK_VERSION=7.17.7
ENV CONTAINER_ID=*
ENV HEAPSIZE_MAX=-Xmx512m
ENV HEAPSIZE_MIN=-Xms512m 

#  -Xms512m -Xmx512m


RUN apt-get update -qq >/dev/null 2>&1 \
 && apt-get install wget sudo -qqy >/dev/null 2>&1 \
 && useradd -m -s /bin/bash elasticsearch \
 && echo elasticsearch ALL=NOPASSWD: ALL >/etc/sudoers.d/elasticsearch \
 && chmod 440 /etc/sudoers.d/elasticsearch

RUN mkdir -p /var/lib/docker/containers

RUN apt-get install gnupg gnupg2 gnupg1 -y \
    &&  wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - \
	&&  apt-get install apt-transport-https -y \
	&& echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list \
    && apt-get update && apt-get install filebeat -y  \
    && apt-get install metricbeat -y \
    && apt-get install apm-server=7.17.7 -y 

COPY filebeat.yml /etc/filebeat/filebeat.yml
COPY ./metricbeat/metricbeat.yml /etc/metricbeat/metricbeat.yml
COPY ./metricbeat/docker.yml /home/elasticsearch/docker.yml
COPY apm-server.yml /etc/apm-server/apm-server.yml

COPY entrypoint.sh /home/elasticsearch/entrypoint.sh

RUN chmod 755 /home/elasticsearch/entrypoint.sh

RUN chmod 666 /etc/filebeat/filebeat.yml && chmod go-w /etc/filebeat/filebeat.yml
RUN chmod 666 /etc/metricbeat/metricbeat.yml && chmod go-w /etc/metricbeat/metricbeat.yml
RUN chmod 666 /etc/apm-server/apm-server.yml && chmod go-w /etc/apm-server/apm-server.yml




WORKDIR /home/elasticsearch

USER elasticsearch

RUN wget -q -O - https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${EK_VERSION}-no-jdk-linux-x86_64.tar.gz | tar -zx \
 && mkdir -p elasticsearch-${EK_VERSION}/data \
 && wget -q -O - https://artifacts.elastic.co/downloads/kibana/kibana-${EK_VERSION}-linux-x86_64.tar.gz | tar -zx \
 && echo $HEAPSIZE_MIN >> elasticsearch-${EK_VERSION}/config/jvm.options.d/memory.txt \
 && echo $HEAPSIZE_MAX >> elasticsearch-${EK_VERSION}/config/jvm.options.d/memory.txt 

ENTRYPOINT [ "sh","entrypoint.sh" ]

EXPOSE 9200 5601 8200

