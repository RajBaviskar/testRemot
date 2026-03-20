

# AWS CDK Infrastructure - S3 and EC2 Multi-Environment (Python)

This AWS CDK project provisions S3 buckets and EC2 instances across multiple environments (dev and prod) using Python 3.13.

## 📋 Project Information

- **AWS CDK Version**: 2.237.0
- **Programming Language**: Python
- **Language Version**: 3.13
- **Package Manager**: pip
- **Package Manager Version**: 25.2

## 🏗️ Architecture

The project creates the following resources for each environment:

### Resources Created
1. **S3 Bucket**
   - Versioning enabled
   - Server-side encryption (S3 managed)
   - Block all public access
   - Lifecycle rules for old versions (90 days)
   - SSL enforcement

2. **EC2 Instance**
   - Amazon Linux 2 AMI (latest)
   - Instance type: t3.micro (dev) / t3.small (prod)
   - IAM instance profile with S3 access
   - Security group with SSH access
   - SSM Session Manager enabled
   - User data for AWS CLI installation

3. **IAM Role**
   - EC2 assume role policy
   - S3 read/write permissions
   - SSM managed instance core policy

## 📁 Project Structure

```
rajCDK-python/
├── app.py                              # CDK app entry point
├── config/
│   ├── __init__.py
│   └── environment_config.py           # Environment-specific configurations
├── stacks/
│   ├── __init__.py
│   └── infrastructure_stack.py         # Main infrastructure stack
├── cdk.json                            # CDK configuration
├── requirements.txt                    # Python dependencies
├── requirements-dev.txt                # Development dependencies
└── README.md                           # This file
```

## 🚀 Getting Started

### Prerequisites

1. **Python 3.13** (or compatible version)
   ```bash
   python3 --version
   ```

2. **pip 25.2** (or compatible version)
   ```bash
   pip --version
   ```

3. **AWS CLI** configured with credentials
   ```bash
   aws configure
   ```

4. **AWS CDK CLI**
   ```bash
   npm install -g aws-cdk@2.237.0
   cdk --version
   ```

### Installation

1. **Create and activate virtual environment**
   ```bash
   cd /Users/rajendrabaviskar/testRemot/IaCM/rajCDK-python
   
   # Create virtual environment
   python3 -m venv .venv
   
   # Activate virtual environment
   # On macOS/Linux:
   source .venv/bin/activate
   
   # On Windows:
   # .venv\Scripts\activate
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Install development dependencies** (optional)
   ```bash
   pip install -r requirements-dev.txt
   ```

4. **Bootstrap CDK** (first time only, per account/region)
   ```bash
   cdk bootstrap aws://ACCOUNT-ID/us-east-1
   ```

## 📦 Environment Configuration

Environments are defined in `config/environment_config.py`:

### Dev Environment
- **Region**: us-east-1
- **S3 Bucket**: dev-raj-cdk-py-artifacts
- **EC2 Type**: t3.micro
- **EC2 Name**: dev-raj-ec2

### Prod Environment
- **Region**: us-east-1
- **S3 Bucket**: prod-raj-cdk-py-artifacts
- **EC2 Type**: t3.small
- **EC2 Name**: prod-raj-ec2

## 🔧 Usage

### Synthesize CloudFormation Templates

**Dev environment:**
```bash
cdk synth --context environment=dev
```

**Prod environment:**
```bash
cdk synth --context environment=prod
```

### View Differences (Diff)

**Dev environment:**
```bash
cdk diff --context environment=dev
```

**Prod environment:**
```bash
cdk diff --context environment=prod
```

### Deploy Infrastructure

**Deploy to Dev:**
```bash
cdk deploy --context environment=dev
```

**Deploy to Prod:**
```bash
cdk deploy --context environment=prod
```

**Deploy with auto-approve:**
```bash
cdk deploy --context environment=dev --require-approval never
```

### Destroy Infrastructure

**Destroy Dev:**
```bash
cdk destroy --context environment=dev
```

**Destroy Prod:**
```bash
cdk destroy --context environment=prod
```

## 📤 Stack Outputs

After deployment, you'll receive the following outputs:

- `S3BucketName` - Name of the S3 bucket
- `S3BucketArn` - ARN of the S3 bucket
- `EC2InstanceId` - EC2 instance ID
- `EC2PublicIP` - Public IP address of the EC2 instance
- `EC2RoleName` - IAM role name
- `EC2RoleArn` - IAM role ARN

View outputs:
```bash
aws cloudformation describe-stacks \
  --stack-name raj-cdk-py-dev-infrastructure \
  --query 'Stacks[0].Outputs'
```

## 🔐 Security Features

1. **S3 Bucket**
   - ✅ Block all public access
   - ✅ Server-side encryption enabled
   - ✅ SSL/TLS enforcement
   - ✅ Versioning enabled

2. **EC2 Instance**
   - ✅ IAM role with least privilege
   - ✅ SSM Session Manager (no SSH keys needed)
   - ✅ Security group with controlled access

3. **IAM**
   - ✅ Scoped S3 permissions
   - ✅ No hardcoded credentials

## 🧪 Testing S3 Access from EC2

Once deployed, connect to your EC2 instance:

**Using SSM Session Manager (recommended):**
```bash
aws ssm start-session --target <instance-id>
```

**Test S3 access:**
```bash
# List bucket contents
aws s3 ls s3://dev-raj-cdk-py-artifacts/

# Upload a test file
echo "Hello from EC2" > test.txt
aws s3 cp test.txt s3://dev-raj-cdk-py-artifacts/

# Download the file
aws s3 cp s3://dev-raj-cdk-py-artifacts/test.txt downloaded.txt
```

## 📝 Customization

### Change Instance Type

Edit `config/environment_config.py`:
```python
ec2_instance_type="t3.medium",  # Change from t3.micro
```

### Add New Environment

Add to `ENVIRONMENT_CONFIGS` in `config/environment_config.py`:
```python
"staging": EnvironmentConfig(
    environment_name="staging",
    region="us-east-1",
    s3_bucket_name="staging-raj-cdk-py-artifacts",
    ec2_instance_type="t3.small",
    ec2_instance_name="staging-raj-ec2",
    tags={
        "Environment": "staging",
        "Owner": "staging-team",
        "ManagedBy": "CDK-Python"
    }
)
```

Deploy:
```bash
cdk deploy --context environment=staging
```

## 🛠️ Development Workflow

1. **Activate virtual environment**
   ```bash
   source .venv/bin/activate
   ```

2. **Make changes** to Python files

3. **Synthesize** to see CloudFormation changes:
   ```bash
   cdk synth --context environment=dev
   ```

4. **Diff** to compare with deployed stack:
   ```bash
   cdk diff --context environment=dev
   ```

5. **Deploy** when ready:
   ```bash
   cdk deploy --context environment=dev
   ```

## 🧹 Code Quality

Run linters and formatters:

```bash
# Format code with black
black .

# Lint with flake8
flake8 .

# Type checking with mypy
mypy .
```

## 🗑️ Cleanup

To remove all resources:

```bash
# Dev environment
cdk destroy --context environment=dev

# Prod environment
cdk destroy --context environment=prod
```

**Note**: S3 buckets have `RETAIN` removal policy, so they won't be deleted automatically. To delete them:
```bash
aws s3 rb s3://dev-raj-cdk-py-artifacts --force
aws s3 rb s3://prod-raj-cdk-py-artifacts --force
```

## 📚 Useful CDK Commands

- `cdk ls` - List all stacks
- `cdk synth` - Synthesize CloudFormation template
- `cdk diff` - Compare deployed stack with current state
- `cdk deploy` - Deploy stack to AWS
- `cdk destroy` - Remove stack from AWS
- `cdk doctor` - Check CDK environment
- `cdk docs` - Open CDK documentation

## 🐛 Troubleshooting

### Virtual Environment Issues
```bash
# Deactivate and recreate
deactivate
rm -rf .venv
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Bootstrap Error
```bash
cdk bootstrap
```

### VPC Not Found
Ensure you have a default VPC in the region, or modify the stack to create a custom VPC.

### Permission Denied
Check your AWS credentials and IAM permissions.

### Python Import Errors
Make sure virtual environment is activated and dependencies are installed.

## 📖 Resources

- [AWS CDK Python Documentation](https://docs.aws.amazon.com/cdk/api/v2/python/)
- [CDK Workshop](https://cdkworkshop.com/)
- [AWS CDK Examples - Python](https://github.com/aws-samples/aws-cdk-examples/tree/master/python)
- [Python CDK API Reference](https://docs.aws.amazon.com/cdk/api/v2/python/index.html)

## 📄 License

MIT
