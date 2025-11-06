remote_state {
  backend = "gcs"

  config = {
    bucket   = "raj-tg-state"
    prefix   = "terraform/state/${path_relative_to_include()}"
    project  = "iac-play"
    location = "us-central1"
  }
}

terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=${find_in_parent_folders("common.tfvars", "")}"
    ]
  }
}
