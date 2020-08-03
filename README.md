# Encrypted Terraform Variables

Example of how to use encrypted variables in Terraform.

This is using [sops](https://github.com/mozilla/sops) but you should be able to use any encryption tool as long as it returns JSON (you can use a wrapper script if it doesn't see more [here](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source)).

Note:
| This does not encrypt .tfstate or avoid outputting sensitive values in `terraform plan` output.
---