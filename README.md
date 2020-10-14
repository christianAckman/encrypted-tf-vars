# Encrypted Terraform Variables

Example of how to use encrypted variables in Terraform.

How it works:
1. Encrypt sensitive variables in advance
2. Decrypt variables at the beginning of `terraform apply` for use in other resources.

This is using [ktool](https://github.com/christianackman/ktool) to encrypt/decrypt but you should be able to use any encryption tool using this same method.

# Warning:
This does not encrypt `.tfstate` or avoid outputting sensitive values in `terraform plan` output.

# References:
https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source
