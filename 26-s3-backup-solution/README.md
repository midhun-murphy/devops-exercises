# Exercise 26 - S3 Backup Solution

## Overview

This project demonstrates how to implement a backup and restore solution using **Amazon S3** and the **AWS CLI**.

The solution backs up both **application files** and **configuration files** to an Amazon S3 bucket and demonstrates restoring them after simulating data loss.

---

## Objective

- Backup application files to Amazon S3
- Backup configuration files to Amazon S3
- Enable S3 bucket versioning
- Restore files from S3
- Demonstrate disaster recovery

---

## Architecture

```
                +----------------------+
                |  Flask Application   |
                +----------+-----------+
                           |
                           |
                    backup.sh
                           |
                           |
                    AWS CLI (S3)
                           |
                           |
          +-------------------------------+
          |      Amazon S3 Bucket         |
          | factorial-backup-exercise     |
          +-------------------------------+
                           |
                           |
                    restore.sh
                           |
                           |
                Restored Application
```

---

# Project Structure

```
26-s3-backup-solution
│
├── app
│   ├── app.py
│   ├── requirements.txt
│   └── templates
│       └── index.html
│
├── config
│   ├── app.conf
│   ├── backup.conf
│   └── environment.conf
│
├── scripts
│   ├── backup.sh
│   └── restore.sh
│
├── screenshots
│
├── README.md
└── .gitignore
```

---

# Technologies Used

- Python 3
- Flask
- Amazon S3
- AWS CLI
- Git Bash
- Git & GitHub

---

# Prerequisites

- AWS Account
- AWS CLI installed and configured
- Python 3.x
- Flask
- Git Bash

---

# S3 Bucket

Bucket Name

```
factorial-backup-exercise
```

Bucket Versioning

```
Enabled
```

---

# Backup Process

The backup script uploads:

### Application Files

```
app/
```

- app.py
- requirements.txt
- templates/index.html

### Configuration Files

```
config/
```

- app.conf
- backup.conf
- environment.conf

Backups are stored using timestamp-based folders.

Example:

```
backups/

2026-06-25_15-49-57/

    app/

    config/
```

---

# Running the Backup

Go to the scripts folder.

```bash
cd scripts
```

Run

```bash
./backup.sh
```

Verify

```bash
aws s3 ls s3://factorial-backup-exercise/backups/ --recursive
```

---

# Restore Process

Simulate a disaster by deleting:

```
app/
config/
```

Run

```bash
cd scripts

./restore.sh <backup-folder>
```

Example

```bash
./restore.sh 2026-06-25_15-49-57
```

The application and configuration files are restored from Amazon S3.

---

# Disaster Recovery Workflow

```
Application Running

        │

        ▼

Backup to Amazon S3

        │

        ▼

Delete Local Files

        │

        ▼

Restore from Amazon S3

        │

        ▼

Application Running Again
```

---

# Screenshots

The project includes screenshots demonstrating:

- Application Running
- S3 Bucket
- Bucket Versioning Enabled
- Backup Script Execution
- Backup Files in S3
- Delete Application & Configuration
- Restore Execution
- Application Running After Restore

---

# Learning Outcomes

- Amazon S3 Backup Strategy
- AWS CLI Commands
- Shell Scripting
- Disaster Recovery
- S3 Bucket Versioning
- Backup Automation
- Restore Automation

---

# Author

**Midhun Kumar V**


