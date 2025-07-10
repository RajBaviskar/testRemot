locals {
  source_path = "${get_repo_root()}/IaCM/harnessTG/modules/harness-service"
}

terraform {
  source = local.source_path
}
