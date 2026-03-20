"""Infrastructure stack for S3 and EC2 resources."""

from aws_cdk import (
    Stack,
    CfnOutput,
    RemovalPolicy,
    Duration,
    Tags,
)
from aws_cdk import aws_s3 as s3
from aws_cdk import aws_ec2 as ec2
from aws_cdk import aws_iam as iam
from constructs import Construct

from config.environment_config import EnvironmentConfig


class InfrastructureStack(Stack):
    """CDK Stack for provisioning S3 and EC2 infrastructure."""

    def __init__(
        self,
        scope: Construct,
        construct_id: str,
        config: EnvironmentConfig,
        **kwargs
    ) -> None:
        """
        Initialize the Infrastructure Stack.
        
        Args:
            scope: CDK app scope
            construct_id: Unique identifier for this construct
            config: Environment-specific configuration
            **kwargs: Additional stack properties
        """
        super().__init__(scope, construct_id, **kwargs)

        self.config = config

        # Create S3 Bucket
        self.s3_bucket = self._create_s3_bucket()

        # Create IAM Role for EC2
        self.ec2_role = self._create_ec2_role()

        # Grant S3 access to EC2 role
        self.s3_bucket.grant_read_write(self.ec2_role)

        # Create EC2 Instance
        self.ec2_instance = self._create_ec2_instance()

        # Create CloudFormation outputs
        self._create_outputs()

    def _create_s3_bucket(self) -> s3.Bucket:
        """
        Create S3 bucket with security best practices.
        
        Returns:
            S3 Bucket construct
        """
        bucket = s3.Bucket(
            self,
            "ArtifactsBucket",
            bucket_name=self.config.s3_bucket_name,
            versioned=True,
            encryption=s3.BucketEncryption.S3_MANAGED,
            block_public_access=s3.BlockPublicAccess.BLOCK_ALL,
            removal_policy=RemovalPolicy.RETAIN,
            auto_delete_objects=False,
            enforce_ssl=True,
            lifecycle_rules=[
                s3.LifecycleRule(
                    id="DeleteOldVersions",
                    enabled=True,
                    noncurrent_version_expiration=Duration.days(90),
                )
            ],
        )

        # Add tags to bucket
        for key, value in self.config.tags.items():
            Tags.of(bucket).add(key, value)

        return bucket

    def _create_ec2_role(self) -> iam.Role:
        """
        Create IAM role for EC2 instances.
        
        Returns:
            IAM Role construct
        """
        role = iam.Role(
            self,
            "EC2Role",
            role_name=f"{self.config.environment_name}-raj-cdk-ec2-role",
            assumed_by=iam.ServicePrincipal("ec2.amazonaws.com"),
            description=f"IAM role for EC2 instances in {self.config.environment_name} environment",
            managed_policies=[
                iam.ManagedPolicy.from_aws_managed_policy_name(
                    "AmazonSSMManagedInstanceCore"
                )
            ],
        )

        # Add custom inline policy for S3 access
        role.add_to_policy(
            iam.PolicyStatement(
                effect=iam.Effect.ALLOW,
                actions=[
                    "s3:GetObject",
                    "s3:PutObject",
                    "s3:ListBucket",
                ],
                resources=[
                    self.s3_bucket.bucket_arn,
                    f"{self.s3_bucket.bucket_arn}/*",
                ],
            )
        )

        # Add tags to role
        for key, value in self.config.tags.items():
            Tags.of(role).add(key, value)

        return role

    def _create_ec2_instance(self) -> ec2.Instance:
        """
        Create EC2 instance with security group and user data.
        
        Returns:
            EC2 Instance construct
        """
        # Get default VPC
        vpc = ec2.Vpc.from_lookup(self, "DefaultVPC", is_default=True)

        # Create Security Group
        security_group = ec2.SecurityGroup(
            self,
            "EC2SecurityGroup",
            vpc=vpc,
            description=f"Security group for {self.config.environment_name} EC2 instance",
            allow_all_outbound=True,
        )

        # Allow SSH from anywhere (restrict in production)
        security_group.add_ingress_rule(
            ec2.Peer.any_ipv4(),
            ec2.Port.tcp(22),
            "Allow SSH access"
        )

        # Get latest Amazon Linux 2 AMI
        ami = ec2.MachineImage.latest_amazon_linux2(
            cpu_type=ec2.AmazonLinuxCpuType.X86_64
        )

        # Create EC2 Instance
        instance = ec2.Instance(
            self,
            "EC2Instance",
            instance_name=self.config.ec2_instance_name,
            vpc=vpc,
            instance_type=ec2.InstanceType(self.config.ec2_instance_type),
            machine_image=ami,
            role=self.ec2_role,
            security_group=security_group,
            vpc_subnets=ec2.SubnetSelection(subnet_type=ec2.SubnetType.PUBLIC),
            ssm_session_permissions=True,
        )

        # Add user data
        instance.user_data.add_commands(
            "#!/bin/bash",
            "yum update -y",
            "yum install -y aws-cli",
            f'echo "S3 Bucket: {self.s3_bucket.bucket_name}" > /tmp/s3-bucket.txt',
            f'aws s3 ls s3://{self.s3_bucket.bucket_name}/ || echo "Bucket access configured"',
        )

        # Add tags to instance
        for key, value in self.config.tags.items():
            Tags.of(instance).add(key, value)

        return instance

    def _create_outputs(self) -> None:
        """Create CloudFormation outputs for stack resources."""
        CfnOutput(
            self,
            "S3BucketName",
            value=self.s3_bucket.bucket_name,
            description="S3 Bucket Name",
            export_name=f"{self.config.environment_name}-s3-bucket-name",
        )

        CfnOutput(
            self,
            "S3BucketArn",
            value=self.s3_bucket.bucket_arn,
            description="S3 Bucket ARN",
            export_name=f"{self.config.environment_name}-s3-bucket-arn",
        )

        CfnOutput(
            self,
            "EC2InstanceId",
            value=self.ec2_instance.instance_id,
            description="EC2 Instance ID",
            export_name=f"{self.config.environment_name}-ec2-instance-id",
        )

        CfnOutput(
            self,
            "EC2PublicIP",
            value=self.ec2_instance.instance_public_ip,
            description="EC2 Instance Public IP",
            export_name=f"{self.config.environment_name}-ec2-public-ip",
        )

        CfnOutput(
            self,
            "EC2RoleName",
            value=self.ec2_role.role_name,
            description="IAM Role Name for EC2",
            export_name=f"{self.config.environment_name}-ec2-role-name",
        )

        CfnOutput(
            self,
            "EC2RoleArn",
            value=self.ec2_role.role_arn,
            description="IAM Role ARN for EC2",
            export_name=f"{self.config.environment_name}-ec2-role-arn",
        )
