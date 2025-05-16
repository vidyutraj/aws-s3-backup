#!/bin/bash

# Variables
BUCKET_NAME="s3-backup-vidyutraj-123"
SOURCE_DIR="./files-to-backup"
REPORT_FILE="./upload_report.txt"

# Step 1: Check if the bucket is public
echo "Checking if the bucket is public..."
IS_PUBLIC="false"

# Check bucket ACL for public access
if aws s3api get-bucket-acl --bucket "$BUCKET_NAME" | grep -q 'http://acs.amazonaws.com/groups/global/AllUsers'; then
    IS_PUBLIC="true"
fi

# Check bucket policy for public access
if aws s3api get-bucket-policy --bucket "$BUCKET_NAME" 2>/dev/null | grep -q '"Effect": "Allow"'; then
    if aws s3api get-bucket-policy --bucket "$BUCKET_NAME" 2>/dev/null | grep -q '"Principal": "*"'; then
        IS_PUBLIC="true"
    fi
fi

if [ "$IS_PUBLIC" == "true" ]; then
    echo "The bucket $BUCKET_NAME is public." | tee -a "$REPORT_FILE"
else
    echo "The bucket $BUCKET_NAME is private." | tee -a "$REPORT_FILE"
fi

# Step 2: Upload files to S3
echo "Uploading files to S3..."
for file in "$SOURCE_DIR"/*; do
    aws s3 cp "$file" "s3://$BUCKET_NAME/"
    echo "Uploaded: $(basename "$file")"
done

# Step 3: Generate report
echo "Generating report..."
echo "Uploaded Files Report" > "$REPORT_FILE"
echo "=====================" >> "$REPORT_FILE"
for file in "$SOURCE_DIR"/*; do
    FILENAME=$(basename "$file")
    FILESIZE=$(stat -c%s "$file")
    echo "File: $FILENAME, Size: $FILESIZE bytes" >> "$REPORT_FILE"
done

# Step 4: Verify files in S3
echo "Verifying uploaded files..."
echo "Verification Results" >> "$REPORT_FILE"
echo "=====================" >> "$REPORT_FILE"
for file in "$SOURCE_DIR"/*; do
    FILENAME=$(basename "$file")
    if aws s3 ls "s3://$BUCKET_NAME/$FILENAME" > /dev/null 2>&1; then
        echo "$FILENAME exists in S3." >> "$REPORT_FILE"
    else
        echo "$FILENAME is missing in S3!" >> "$REPORT_FILE"
    fi
done

echo "Backup, bucket check, and verification complete. Report saved to $REPORT_FILE."