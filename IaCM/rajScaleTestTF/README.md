# rajScaleTestTF

Path: `IaCM/rajScaleTestTF`.

Uses built-in **`terraform_data`** (Terraform ≥ 1.4). No `null` provider. Apply does not write files and does not call AWS/GCP.

UI addresses: `terraform_data.hello["r-00000"]`

| Variable | Default | What it changes |
|---|---|---|
| `resource_count` | 200 | How many `hello` instances |
| `blob_kib` | 4 | Dummy KiB on **each** instance |
| `wave` | `"1"` | Bump after apply so the next plan has updates |

## Why not a single hello-world file?

A one-line `local_file` (like SimpleTF) makes **one** resource. Plan/state stay small unless that one file’s content is huge — then you get a big file but **one row** in Resources. Twilio-scale is **many rows and a fat JSON plan**.

`locals` and unused variables are **not** stored in state. They do not show up as resources.

`null_resource` works but needs the `hashicorp/null` provider and looks like “provisioning.” `terraform_data` is the same idea built into Terraform: the instance exists only in plan/state.

Each `hello` instance carries `blob`. Terraform copies that into plan JSON (several times) and into state after apply. IaCM still lists them as managed resources.

| resource_count | blob_kib | Rough plan | Rough state |
|---|---|---|---|
| 200 | 4 | a few MiB | ~1 MiB |
| 1000 | 8 | tens of MiB | ~8 MiB |
| 2000 | 16 | toward 100+ MiB | ~32 MiB |

## Workspace

**Terraform folder:** `IaCM/rajScaleTestTF`

1. Plan — pipeline Resources shows creates.
2. Apply — workspace Resources shows `resource_count` rows.
3. Set `wave` to `"2"` and plan/apply again for updates.

```bash
cd IaCM/rajScaleTestTF
terraform init
terraform plan -out=tfplan
terraform apply tfplan
terraform state list | wc -l
ls -lh terraform.tfstate
```
