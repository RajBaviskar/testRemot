locals {
  # range() allows at most 1024 values, so nest loops instead of range(blob_kib*1024).
  blob = join("", flatten([
    for _ in range(1024) : [
      for _ in range(var.blob_kib) : "x"
    ]
  ]))

  keys = slice(flatten([
    for b in range(ceil(var.resource_count / 1024)) : [
      for i in range(1024) : format("r-%05d", b * 1024 + i)
    ]
  ]), 0, var.resource_count)
}

# Built-in from Terraform 1.4. Apply writes state only — no provider, no disk
# files, no cloud. IaCM lists terraform_data.hello["r-00000"], …
resource "terraform_data" "hello" {
  for_each = toset(local.keys)

  input = {
    id   = each.key
    wave = var.wave
    blob = local.blob
  }
}
