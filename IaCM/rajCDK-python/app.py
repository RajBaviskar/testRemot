#!/usr/bin/env python3
"""CDK app entry point for infrastructure provisioning."""

import os
import aws_cdk as cdk

from stacks.infrastructure_stack import InfrastructureStack
from config.environment_config import get_environment_config


app = cdk.App()

# Get environment from context (passed via --context environment=dev)
environment_name = app.node.try_get_context("environment") or "dev"

print(f"Deploying infrastructure for environment: {environment_name}")

# Get environment-specific configuration
config = get_environment_config(environment_name)

# Create the infrastructure stack
InfrastructureStack(
    app,
    f"RajCDKPyInfraStack-{config.environment_name}",
    config=config,
    env=cdk.Environment(
        account=os.getenv("CDK_DEFAULT_ACCOUNT"),
        region=config.region,
    ),
    stack_name=f"raj-cdk-py-{config.environment_name}-infrastructure",
    description=f"Infrastructure stack for {config.environment_name} environment - S3 and EC2 resources (Python CDK)",
    tags={
        **config.tags,
        "Stack": f"raj-cdk-py-{config.environment_name}-infrastructure",
    },
)

app.synth()
