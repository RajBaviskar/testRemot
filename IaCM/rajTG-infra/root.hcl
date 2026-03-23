remote_state {
  backend = "s3"
  config = {
    bucket         = "raj-tg-test-seq-new"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tg-lock-table"
  }
}

inputs = {
  env = "dev"
}
