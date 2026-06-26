#!/bin/bash

# Get the project root directory
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Bucket name
BUCKET_NAME="factorial-backup-exercise"

# Timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

echo "======================================="
echo "Starting Backup..."
echo "======================================="

echo "Uploading application files..."

aws s3 cp "$PROJECT_DIR/app" \
"s3://$BUCKET_NAME/backups/$TIMESTAMP/app" \
--recursive

echo "Uploading configuration files..."

aws s3 cp "$PROJECT_DIR/config" \
"s3://$BUCKET_NAME/backups/$TIMESTAMP/config" \
--recursive

echo ""
echo "Backup completed successfully!"
echo ""
echo "Backup Location:"
echo "s3://$BUCKET_NAME/backups/$TIMESTAMP/"