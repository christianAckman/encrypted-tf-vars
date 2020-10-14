#!/bin/bash
## https://github.com/hashicorp/terraform-provider-external/issues/14#issuecomment-441793448
## requirements: jq and ktool on $PATH
set -e

# https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source#processing-json-in-shell-scripts
eval "$(jq -r '@sh "KMS_DATA_KEY=\(.KMS_DATA_KEY) ENCRYPTED_FILE=\(.ENCRYPTED_FILE)"')"
arr=$(echo "$ENCRYPTED_FILE" | jq -r '. | to_entries | .[] | .key + "=" + .value')

# loop decrypt json values
for json in ${arr[@]}
do
    key=$(echo "$json" | cut -d'=' -f1)
    val=$(echo "$json" | cut -d'=' -f2)
    decryptedVal=$(ktool decrypt -k "${KMS_DATA_KEY}" -d "${val}")
    decryptedJSON+="$(jq -n --arg key "$key" --arg val "$decryptedVal" '{($key):$val}' '.[]')"
done;

# combine the json objects
echo "$decryptedJSON" | jq -s add
