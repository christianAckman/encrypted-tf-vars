data "external" "decrypt" {
  program = ["sops", "--decrypt", "encrypted.json"]
}

locals {
  database_username = data.external.decrypt.result["database_username"]
  database_password = data.external.decrypt.result["database_password"]
}

##
## example usage:
##
# resource "aws_db_instance" "rds" {
#   username = local.rds_username
#   password = local.rds_password
#   ...
# }
