#!/bin/bash

# -----------------------------
# S3 Restore Script
# -----------------------------

BUCKET_NAME="factorial-backup-exercise"

# Check if backup folder name is provided
if [ -z "$1" ]; then
    echo "Usage:"
    echo "./restore.sh <backup-folder>"
    exit 1
fi

BACKUP_FOLDER=$1

echo "======================================="
echo "Starting Restore..."
echo "======================================="

# Create application folder
mkdir -p ../app

# Create config folder
mkdir -p ../config

echo "Restoring application files..."

aws s3 cp \
s3://$BUCKET_NAME/backups/$BACKUP_FOLDER/app \
../app \
--recursive

echo ""

echo "Restoring configuration files..."

aws s3 cp \
s3://$BUCKET_NAME/backups/$BACKUP_FOLDER/config \
../config \
--recursive

echo ""
echo "======================================="
echo "Restore Completed Successfully!"
echo "======================================="