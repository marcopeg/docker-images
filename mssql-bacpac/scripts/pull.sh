#!/bin/bash
set -e

# Reset AWS credentials
rm -rf ~/.aws
mkdir -p ~/.aws
echo "[default]" >> ~/.aws/credentials
echo "aws_access_key_id = ${AWS_ACCESS_KEY}" >> ~/.aws/credentials
echo "aws_secret_access_key = ${AWS_ACCESS_SECRET}" >> ~/.aws/credentials

SOURCE_FILE="${1:-"default"}.bacpac"

clear
echo "###"
echo "### Reviso State"
echo "###"
echo ""
echo "downloading: ${SOURCE_FILE} from s3://${AWS_BUCKET_NAME}..."
echo ""

mkdir -p /bacpac
aws s3 cp s3://${AWS_BUCKET_NAME}/${SOURCE_FILE} /bacpac