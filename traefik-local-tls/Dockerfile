FROM traefik:v2.8

RUN mkdir -p /etc/traefik/

#
# Traefik Static Config
#
RUN printf '\
global: \n\
  sendAnonymousUsage: false \n\
\n\
log: \n\
  level: INFO \n\
  format: common \n\
\n\
api: \n\
  dashboard: true \n\
  insecure: true \n\
\n\
providers: \n\
  docker: \n\
    endpoint: unix:///var/run/docker.sock \n\
    watch: true \n\
    exposedByDefault: false \n\
\n\
  file: \n\
    filename: /etc/traefik/dynamic.yml \n\
    watch: true \n\
\n\
entryPoints: \n\
  http: \n\
    address: :80 \n\
    http: \n\
      redirections: \n\
        entryPoint: \n\
          to: https \n\
          scheme: https \n\
  https: \n\
    address: :443 \n\
    http: \n\
      tls: true \n\
' >> /etc/traefik/traefik.yml

#
# Traefik Dynamic Config
#
RUN printf '\
http: \n\
  routers: \n\
    traefik: \n\
      rule: "Host(`traefik.docker.localhost`)" \n\
      service: "api@internal" \n\
\n\
tls: \n\
  certificates: \n\
    - certFile: "/etc/certs/local-cert.pem" \n\
      keyFile: "/etc/certs/local-key.pem" \n\
\n\
' >> /etc/traefik/dynamic.yml
