Terragrunt multi-env multi-region example repo.
Structure:
infra/
  - terragrunt.hcl        # global remote state backend (S3 + DynamoDB)
  - variables.hcl         # global locals
  - envs/
     - dev/ prod/
        - terragrunt.hcl  # env level
        - variables.hcl
        - us-east-1/ us-west-2/
           - terragrunt.hcl  # region level
           - variables.hcl
           - vpc/ ec2/ s3/ rds/  # modules

Notes:
- This repo is for demo / scaffolding. Replace module sources and secrets before using in production.
- The RDS password in example is placeholder; use secrets manager or TF variables with appropriate protections.
