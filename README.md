# AWS S3, Bash, and AWS CLI Lab

## Overview

This project demonstrates the use of AWS S3, Bash scripting, and the AWS CLI to automate file uploads, check S3 bucket configurations, and generate detailed reports. It is designed as a hands-on lab to build practical skills with these technologies, including secure file management, automation, and cloud storage best practices.

## Prerequisites

Before starting this lab, make sure you have the following:

1. **AWS Account:** An active AWS account with appropriate permissions.
2. **IAM User with Programmatic Access:** A dedicated IAM user with programmatic access to S3. You will create this in the steps below.
3. **AWS CLI Installed and Configured:** The AWS Command Line Interface (CLI) installed and configured on your local machine.
4. **Bash Shell:** A Linux, macOS, or Windows Subsystem for Linux (WSL) environment.
### **Install AWS CLI**

Before proceeding, ensure you have the AWS CLI installed. If you're using macOS and have Homebrew installed, you can install it with the following command:

```bash
brew install awscli
```

After installation, verify the AWS CLI version:

```bash
aws --version
```

You should see output similar to:

```
aws-cli/2.x.x Python/3.x.x Darwin/x86_64
```

## Cloning This Repository

To get started with this lab, clone this repository to your local machine:

```bash
git clone https://github.com/your-username/aws-s3-backup.git
```

Navigate to the project directory:

```bash
cd aws-s3-backup
```

This repository contains all the necessary files, including the `s3_backup.sh` script, which you will use in the steps below.

### **Step 1: Create an IAM User on AWS**

To securely access your S3 bucket, you need an IAM user with programmatic access.

1. **Log in to the AWS Management Console:** [AWS Console](https://aws.amazon.com/console/)

2. **Go to the IAM Service:**

   * In the search bar, type **IAM** and select **IAM (Identity and Access Management)**.

3. **Create a New User:**

   * Click **Users** on the left sidebar.
   * Click the **Add users** button.
   * **Username:** Choose a username (e.g., `s3test`).
   * **Access Type:** Select **Programmatic access** (required for CLI access).

4. **Set Permissions:**

   * Select **Attach policies directly**.
   * Choose the **AmazonS3FullAccess** policy (or create a more restrictive policy if desired).

5. **Add Tags (Optional):**

   * Add tags for organization, like:

     * **Key:** Project, **Value:** S3-Backup-Lab
     * **Key:** Environment, **Value:** Development

6. **Review and Create User:**

   * Review the settings and click **Create user**.
   * **IMPORTANT:** Copy the **Access Key ID** and **Secret Access Key**. You will need these in the next step.

### **Step 2: Configure the AWS CLI**

Once you have your access keys, configure the AWS CLI:

```bash
aws configure
```

You will be prompted for:

* **Access Key ID:** (Paste your Access Key ID here)
* **Secret Access Key:** (Paste your Secret Access Key here)
* **Default Region Name:** e.g., `us-east-1`
* **Default Output Format:** e.g., `json`

**Example:**

```
AWS Access Key ID [None]: AKIA***************
AWS Secret Access Key [None]: wJal***************
Default region name [None]: us-east-1
Default output format [None]: json
```

### **Step 3: Test Your Configuration**

Verify that your credentials are working:

```bash
aws sts get-caller-identity
```

You should see your AWS account ID, user ARN, and account ID if everything is configured correctly.

### **Step 4: Create an S3 Bucket**

Create a unique S3 bucket for this lab:

```bash
aws s3 mb s3://your-unique-bucket-name
```

**Note:** Replace `your-unique-bucket-name` with a globally unique bucket name.

### **Step 5: Verify the Bucket Creation**

Make sure your bucket was created successfully:

```bash
aws s3 ls
```

You should see your new bucket in the list.

### **Step 6: Set Up Local Files**

Before you can run your S3 backup script, you need to prepare some local files to back up. Follow these steps:

#### **1. Create the Backup Directory**

Create a directory on your local machine where you will place the files you want to back up:

```bash
mkdir files-to-backup
```
#### **2. Add Sample Files**

Create a few sample files to test the backup process:
```bash
echo 'Sample content for File 1' > files-to-backup/file1.txt
echo 'Sample content for File 2' > files-to-backup/file2.txt
```

### **Step 7: Prepare the Bash Script**

Since you cloned this repository, the s3_backup.sh script should already be included. Now, you just need to make it executable and run it.

#### **1. Make the Script Executable**

Grant execute permissions to the script:
```bash
chmod +x s3_backup.sh
```
#### **2. Run the Script**
Before running the script, open the `s3_backup.sh` file in a text editor and update the bucket name to match the one you created:

```bash
BUCKET_NAME="your-unique-bucket-name"
```

Replace `your-unique-bucket-name` with the name of your S3 bucket.

Now run the script to start the backup process:
```bash
./s3_backup.sh
```

This script will:
- Check if the bucket is public or private.
- Upload all files in the files-to-backup directory to the S3 bucket.
- Generate a report of the uploaded files.
- Verify that the files exist in the S3 bucket.

#### **3. Verify the Output**

Check the contents of the generated report:

```bash
cat upload_report.txt
```

You should see a list of uploaded files and their sizes.

### **Step 8: Validate in AWS CLI/AWS Management Console**

<img width="1437" alt="Screen Shot 2025-05-15 at 9 00 20 PM" src="https://github.com/user-attachments/assets/60cbb3a7-7696-4c82-a605-b34534555f9d" />

#### **1. Check Uploaded Files**

Use the AWS CLI to list the files in your S3 bucket:

```bash
aws s3 ls s3://your-unique-bucket-name
```

Confirm that the uploaded files (e.g., `file1.txt`, `file2.txt`) appear in the bucket.

#### **2. Review Bucket ACL and Policy**

Verify that the script correctly identifies whether the bucket is public or private:

```bash
aws s3api get-bucket-acl --bucket your-unique-bucket-name
```

```bash
aws s3api get-bucket-policy --bucket your-unique-bucket-name
```

#### **3. Test Public Access (if applicable)**

If the bucket is public, try accessing a file directly via the browser:

```
https://<BUCKET_NAME>.s3.<REGION>.amazonaws.com/<FILE_NAME>
```

Replace `<BUCKET_NAME>`, `<REGION>`, and `<FILE_NAME>` with your bucket name, region, and file name respectively.

### **Step 9: Clean Up**

After completing the lab, clean up the resources to avoid unnecessary charges and maintain a tidy environment.

#### **1. Delete Uploaded Files from S3**

Remove all files from your S3 bucket:

```bash
aws s3 rm s3://your-unique-bucket-name --recursive
```

#### **2. Delete the S3 Bucket**

Once the bucket is empty, delete it:

```bash
aws s3 rb s3://your-unique-bucket-name
```

#### **3. Remove Local Files**

If you no longer need the local files and script, delete them:

```bash
rm -rf files-to-backup s3_backup.sh upload_report.txt
```

By following these steps, you ensure that no unnecessary resources are left behind.

### **Main Learnings**

1. Gained hands-on experience with AWS S3 and the AWS CLI.
2. Understood how to automate tasks using Bash scripting.
3. Learn to verify and validate S3 bucket configurations for security.

This lab is great for providing hands-on experience with AWS S3, Bash scripting, and the AWS CLI for secure and automated file management.
