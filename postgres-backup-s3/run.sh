#! /bin/sh

set -e

if [ "${S3_S3V4}" = "yes" ]; then
    aws configure set default.s3.signature_version s3v4
fi

if [ "${SCHEDULE}" = "**None**" ]; then
  sh backup.sh

  # Useful to keep alive the process in CapRover
  if [ "${KEEP_ALIVE}" = "**Yes**" ]; then
  echo "Keep instance alive for a hundred years..."
    sleep 3153600000;
  fi
else
  exec go-cron "$SCHEDULE" /bin/sh backup.sh
fi
