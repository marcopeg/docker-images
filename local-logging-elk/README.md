<h3>1-FIRST BUILD THE IMAGE</h3>

docker build . -t elk-filebeat:1.0


<h3>2-THE FOLLOWING COMMAND MUST BE EXECUTED TO RUN THE CONTAINER:</h3>

PS: Using this command, we assume that the docker default log path didn't change

docker run -itd --name elk-filebeat-container --memory="2g" --memory-swap="3g" -p 0.0.0.0:5601:5601 -p 0.0.0.0:9200:9200 \
-v /var/lib/docker/containers:/var/lib/docker/containers:ro \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
--env "ELASTICSEARCH_HOSTS=http://127.0.0.1:9200" elk-filebeat:1.0

<h3 style="color:red;">Filebeat must run when the kibana service is reachable but it takes some time, the dashboard won't be available right away we must wait a few minutes. Then the container must run "filebeat setup" and "metricbeat setup"(to get the index patterns and the preconfigured dashboards on Kibana), both commands take a lot of time so you should wait 5 to 10 minutes before having everything operational </h3>

<h3>3- CHECK THE CONTAINER LOGS:</h3>

You can run 'docker logs -f elk-filebeat:1.0' to watch the setup progression
When you'll see the message 'ELK and APM server are ready' then the container is operational

