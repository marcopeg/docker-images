FROM nginx:1.19.5-alpine

ARG DOCKERIZE_VER
ENV DOCKERIZE_VER ${DOCKERIZE_VER:-v0.6.1}
RUN echo "Dockerize version: ${DOCKERIZE_VER}"

RUN apk --update add curl \
    && curl -LO  https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VER}/dockerize-alpine-linux-amd64-${DOCKERIZE_VER}.tar.gz \
    && tar xfvz dockerize-alpine-linux-amd64-${DOCKERIZE_VER}.tar.gz \
    && mv dockerize /usr/bin/dockerize \
    && apk del curl libcurl libssh2 ca-certificates \
    && rm -rf /var/cache/apk/*


COPY nginx.tmpl.conf /app/nginx.conf.tmpl

## Proxy configuration
ENV NGINX_HOST "_"
ENV NGINX_PORT "80"
ENV NGINX_UPSTREAM_SERVER "127.0.0.1"
ENV NGINX_UPSTREAM_PORT "8080"

## Nginx HTTP Headers for security
# HSTS Example add_header Strict-Transport-Security "max-age=31536000; includeSubDomains";
ENV NGINX_HSTS_HEADER ""
ENV NGINX_CSP_HEADER ""
ENV NGINX_X_XSS_PROTECTION_HEADER 'add_header X-Xss-Protection "1; mode=block" always;'
ENV NGINX_X_CONTENT_TYPE_OPTIONS_HEADER 'add_header X-Content-Type-Options "nosniff" always;'
ENV NGINX_X_FRAME_OPTIONS_HEADER 'add_header X-Frame-Options "SAMEORIGIN" always;'
ENV NGINX_REFERRER_POLICY_HEADER 'add_header Referrer-Policy "no-referrer" always;'

## Misc
# Add the following CIDR IP Ranges to the geo $ip_access_granted variable
# If it's unset the service will allow all traffic (0.0.0.0/0)
ENV NGINX_REAL_IP_CIDR "10.0.0.0/16"
# NGINX_PROXY_REDIRECT controls the proxy_redirect directive in server {}.
# If unset to or to off the following will be added: proxy_redirect   off;
ENV NGINX_PROXY_REDIRECT "off"
# NGINX_PROXY_HEADER_X_FORWARDED_PROTO controls the proxy_set_header        X-Forwarded-Proto in server{}
# If unset it it will use the incoming scheme from the load balancer. This can be used to override the value
ENV NGINX_PROXY_HEADER_X_FORWARDED_PROTO '$scheme'

CMD ["/usr/bin/dockerize", "-template", "/app/nginx.conf.tmpl:/etc/nginx/nginx.conf", "nginx"]
