#!/bin/bash
set -e

# Reset AWS credentials
rm -rf ~/.aws
mkdir -p ~/.aws
echo "[default]" >> ~/.aws/credentials
echo "aws_access_key_id = ${AWS_ACCESS_KEY}" >> ~/.aws/credentials
echo "aws_secret_access_key = ${AWS_ACCESS_SECRET}" >> ~/.aws/credentials


exec_sql() {
  echo "SQL>> $@"
	/opt/mssql-tools/bin/sqlcmd -S "$MSSQL_HOST" -U $MSSQL_USER -P "$MSSQL_PASSWORD" "$@"
}

is_server_ready() {
  echo "checking"
	exec_sql -Q 'SELECT 0;'  &> /dev/null
}

exec_sql() {
	/opt/mssql-tools/bin/sqlcmd -S "$MSSQL_HOST" -U $MSSQL_USER -P "$MSSQL_PASSWORD" "$@"
}

SOURCE_FILE="${1:-"mssql_core_app_0"}.bacpac"

clear
echo "###"
echo "### Restore From Bacpac"
echo "###"
echo ""
echo "source: ${SOURCE_FILE}..."
echo ""


echo "Checking local cache..."
if [[ -f "/bacpac/${SOURCE_FILE}" ]]; then
  echo "${SOURCE_FILE} exists, using local cache"
else
  echo "downloading: ${SOURCE_FILE} from s3://${AWS_BUCKET_NAME}..."
  mkdir -p /bacpac
  aws s3 cp s3://${AWS_BUCKET_NAME}/${SOURCE_FILE} /bacpac
fi
echo ""



# Note: This is meant to be run in the mssql ubuntu image from microsoft
echo "Connecting to: ${MSSQL_USER}@${MSSQL_HOST}:${MSSQL_PORT}"
while ! is_server_ready;
do
  echo "."
  sleep 5
done
echo ""

echo "Dropping database ${MSSQL_DATABASE}"
exec_sql -Q 'USE master;ALTER DATABASE ['${MSSQL_DATABASE}'] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;DROP DATABASE IF EXISTS ['${MSSQL_DATABASE}'];'
echo ""

echo "Importing BacPac: ${SOURCE_FILE}"
/sqlpackage /tsn:${MSSQL_HOST},${MSSQL_PORT} /tu:${MSSQL_USER} /tp:${MSSQL_PASSWORD} /tdn:${MSSQL_DATABASE} /a:Import /sf:/bacpac/${SOURCE_FILE}