# AWS S3, Bash, and AWS CLI Lab

## Overview

This project demonstrates the use of AWS S3, Bash scripting, and the AWS CLI to automate file uploads, check S3 bucket configurations, and generate detailed reports. It is designed as a hands-on lab to build practical skills with these technologies, including secure file management, automation, and cloud storage best practices.

## Prerequisites

Before starting this lab, make sure you have the following:

1. **AWS Account:** An active AWS account with appropriate permissions.
2. **IAM User with Programmatic Access:** A dedicated IAM user with programmatic access to S3. You will create this in the steps below.
3. **AWS CLI Installed and Configured:** The AWS Command Line Interface (CLI) installed and configured on your local machine.
4. **Bash Shell:** A Linux, macOS, or Windows Subsystem for Linux (WSL) environment.

### **Step 1: Create an IAM User on AWS**

To securely access your S3 bucket, you need an IAM user with programmatic access.

1. **Log in to the AWS Management Console:** [AWS Console](https://aws.amazon.com/console/)

2. **Go to the IAM Service:**

   * In the search bar, type **IAM** and select **IAM (Identity and Access Management)**.

3. **Create a New User:**

   * Click **Users** on the left sidebar.
   * Click the **Add users** button.
   * **Username:** Choose a username (e.g., `s3-backup-user`).
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

### **Next Steps**

After setting up your S3 bucket and configuring your AWS CLI, you can proceed to creating the Bash script for automating your backups.

Would you like me to include the script and detailed run instructions in this README as well?
