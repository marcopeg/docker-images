#!/bin/bash
set -e

# Reset AWS credentials
rm -rf ~/.aws
mkdir -p ~/.aws
echo "[default]" >> ~/.aws/credentials
echo "aws_access_key_id = ${AWS_ACCESS_KEY}" >> ~/.aws/credentials
echo "aws_secret_access_key = ${AWS_ACCESS_SECRET}" >> ~/.aws/credentials

clear
echo "###"
echo "### Reviso State"
echo "###"
echo ""
echo "loading from s3://${AWS_BUCKET_NAME}...."
echo ""
aws s3 ls s3://${AWS_BUCKET_NAME}