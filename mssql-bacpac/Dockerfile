FROM mcr.microsoft.com/mssql/server:2019-CU2-ubuntu-16.04
USER root

RUN apt-get update && apt-get install unzip awscli -y

# SqlPackage taken from https://github.com/Microsoft/mssql-docker/issues/135#issuecomment-389245587
RUN wget -O sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=873926 \
   && unzip sqlpackage.zip -d / \
   && chmod +x /sqlpackage

# Import init script
COPY scripts/restore.sh /restore.sh
RUN chmod +x /restore.sh
COPY scripts/list.sh /list.sh
RUN chmod +x /list.sh
COPY scripts/pull.sh /pull.sh
RUN chmod +x /pull.sh

# Define aliases
#RUN echo "alias list=\"/list.sh\"" >> ~/.bashrc
#RUN echo 'alias foobar="echo hello"' >> ~/.bashrc

RUN echo -e '#!/bin/bash\n/restore.sh "$@"' > /usr/bin/restore && chmod +x /usr/bin/restore
RUN echo -e '#!/bin/bash\n/list.sh "$@"' > /usr/bin/list && chmod +x /usr/bin/list
RUN echo -e '#!/bin/bash\n/pull.sh "$@"' > /usr/bin/pull && chmod +x /usr/bin/pull

# These defaults are from the standard docker setup
ENV MSSQL_HOST=mssql
ENV MSSQL_PORT=1433
ENV MSSQL_USER=SA
ENV MSSQL_PASSWORD=xxx
ENV MSSQL_DATABASE=yyy

# How to get data from AWS
ENV AWS_ACCESS_KEY=xxx
ENV AWS_ACCESS_SECRET=yyy
ENV AWS_BUCKET_NAME=xxx

# Seems to be necessary
ENV TERM=xterm

CMD ["/restore.sh"]