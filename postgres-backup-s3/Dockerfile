FROM alpine:3.13.4
LABEL maintainer="Marco Pegoraro <marco.pegoraro@gmail.com>"

# Install dependencies
# https://pkgs.alpinelinux.org/packages?name=postgresql&branch=&repo=main&arch=x86_64&maintainer=
RUN apk update
RUN apk add postgresql
RUN apk add python3 py3-pip curl zip
RUN pip install awscli
RUN curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.7/go-cron-linux.gz | zcat > /usr/local/bin/go-cron
RUN chmod u+x /usr/local/bin/go-cron

# Clenup image
RUN apk del curl
RUN rm -rf /var/cache/apk/*

# Define running environment
ENV POSTGRES_DATABASE **None**
ENV POSTGRES_HOST **None**
ENV POSTGRES_PORT 5432
ENV POSTGRES_USER **None**
ENV POSTGRES_PASSWORD **None**
ENV POSTGRES_EXTRA_OPTS ''
ENV S3_ACCESS_KEY_ID **None**
ENV S3_SECRET_ACCESS_KEY **None**
ENV S3_BUCKET **None**
ENV S3_REGION us-west-1
ENV S3_PATH 'backup'
ENV S3_ENDPOINT **None**
ENV S3_PASSWORD **None**
ENV S3_S3V4 no
ENV SCHEDULE **None**
ENV KEEP_ALIVE **No**

ADD run.sh /run.sh
ADD backup.sh /backup.sh

RUN chmod +x /run.sh
RUN chmod +x /backup.sh

CMD ["sh", "/run.sh"]
