"""Environment-specific configuration for CDK infrastructure."""

from dataclasses import dataclass
from typing import Dict


@dataclass
class EnvironmentConfig:
    """Configuration for a specific environment."""
    
    environment_name: str
    region: str
    s3_bucket_name: str
    ec2_instance_type: str
    ec2_instance_name: str
    tags: Dict[str, str]


# Environment configurations
ENVIRONMENT_CONFIGS = {
    "dev": EnvironmentConfig(
        environment_name="dev",
        region="us-east-1",
        s3_bucket_name="dev-raj-cdk-py-artifacts",
        ec2_instance_type="t3.micro",
        ec2_instance_name="dev-raj-cdk-ec2",
        tags={
            "Environment": "dev",
            "Owner": "dev-team",
            "ManagedBy": "CDK-Python"
        }
    ),
    "prod": EnvironmentConfig(
        environment_name="prod",
        region="us-east-1",
        s3_bucket_name="prod-raj-cdk-py-artifacts",
        ec2_instance_type="t3.small",
        ec2_instance_name="prod-raj-cdk-ec2",
        tags={
            "Environment": "prod",
            "Owner": "prod-team",
            "ManagedBy": "CDK-Python"
        }
    )
}


def get_environment_config(environment_name: str) -> EnvironmentConfig:
    """
    Get configuration for a specific environment.
    
    Args:
        environment_name: Name of the environment (dev, prod)
        
    Returns:
        EnvironmentConfig for the specified environment
        
    Raises:
        ValueError: If environment configuration not found
    """
    config = ENVIRONMENT_CONFIGS.get(environment_name)
    if not config:
        raise ValueError(f"Environment configuration not found for: {environment_name}")
    return config
