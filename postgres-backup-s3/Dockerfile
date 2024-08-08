FROM postgres:16-alpine
LABEL maintainer="Marco Pegoraro <marco.pegoraro@gmail.com>"

# Install required tools and awscli
RUN apk update && \
    apk add --no-cache wget ca-certificates python3 py3-pip curl zip aws-cli && \
    update-ca-certificates

# Download and install go-cron
RUN curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.7/go-cron-linux.gz | zcat > /usr/local/bin/go-cron && \
    chmod u+x /usr/local/bin/go-cron

# Cleanup image
RUN apk del curl && \
    rm -rf /var/cache/apk/*

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
