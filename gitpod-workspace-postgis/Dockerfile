# https://hub.docker.com/r/kartoza/postgis/dockerfile
# https://hub.docker.com/r/mdillon/postgis/dockerfile

FROM marcopeg/gitpod-workspace-postgres:2.5.0

RUN sudo apt-get update
RUN sudo apt-get install -y apk
RUN apk

#ARG IMAGE_VERSION

# RUN set -eux
# RUN export DEBIAN_FRONTEND=noninteractive
# RUN sudo apt-get update
# RUN sudo apt-get -y --no-install-recommends install \
#         locales \
#         gnupg2 \
#         wget \
#         ca-certificates \
#         rpl \
#         pwgen \
#         software-properties-common \
#         gdal-bin \
#         iputils-ping
# RUN sudo sh -c "echo \"deb http://apt.postgresql.org/pub/repos/apt/ 16.04-pgdg main\" > /etc/apt/sources.list.d/pgdg.list"
# RUN sudo bash -c 'wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc -O- | apt-key add -'
# RUN sudo apt-get -y --purge autoremove
# RUN sudo apt-get clean
# RUN sudo rm -rf /var/lib/apt/lists/*
# RUN sudo dpkg-divert --local --rename --add /sbin/initctl

# Generating locales takes a long time. Utilize caching by runnig it by itself
# early in the build process.
# COPY src/locale.gen /etc/locale.gen
# RUN set -eux
# RUN sudo /usr/sbin/locale-gen

# ENV LANG=en_US.UTF-8 \
#     LANGUAGE=en_US:en \
#     LC_ALL=en_US.UTF-8
# RUN sudo update-locale ${LANG}

#-------------Application Specific Stuff ----------------------------------------------------

# We add postgis as well to prevent build errors (that we dont see on local builds)
# on docker hub e.g.
# The following packages have unmet dependencies:

# RUN set -eux
# RUN export DEBIAN_FRONTEND=noninteractive
# RUN sudo apt-get update
# RUN sudo apt-get -y --no-install-recommends install postgresql-client-12 \
#         postgresql-common postgresql-12 postgresql-12-postgis-3 \
#         netcat postgresql-12-ogr-fdw postgresql-12-postgis-3-scripts \
#         postgresql-12-cron postgresql-plpython3-12