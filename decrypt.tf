variable "kms_data_key" {
  default = "AQIDAHj6KIndQ20/7uMuFPi8qQkQhTIDeWMVc8w6yFUwFUVEXgEzKfjKhwLKLnVQKMq50Tc7AAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMbikPiMdaeARk1pajAgEQgDve0a5n5K6NI6eq733Urh9K7U3WEUxU62K+rMuABAJZ/GeQkNQW+VEaqOKY3KMXmbysg9M5GYCGvt5BcA=="
}

data "external" "decrypt" {
  program = ["sh", "-c", "./decrypt.sh"]
  query = {
    KMS_DATA_KEY = var.kms_data_key
    ENCRYPTED_FILE = file("secrets.json")
  }
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
