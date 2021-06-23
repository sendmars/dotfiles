#!/bin/sh

# taken from: https://gist.github.com/bertrandmartel/f6b1d1ac1dbd396a94ba0ac9468d5b3a
# https://stackoverflow.com/a/66878739/2614364
# Example credentials setup:
#
# [default]
# aws_secret_access_key = redacted
# aws_access_key_id = redacted
#
# [tf_temp]
#
# [tf]
# credential_process = sh -c 'mfa.sh arn:aws:iam::{account_id}:role/{role} arn:aws:iam::{account_id}:mfa/{mfa_entry} {profile} 2> $(tty)'
#
# Example config:
#
# [profile default]
# region = us-west-2
# output = json
#
# [profile tf]
# source_profile = default
# region = us-west-2
#
# [profile mfa_temp]
# source_profile = default
# region = us-west-2

set -e

role=$1
mfa_arn=$2
profile=$3
temp_profile=mfa_temp

if [ -z $role ]; then echo "no role specified"; exit 1; fi
if [ -z $mfa_arn ]; then echo "no mfa arn specified"; exit 1; fi
if [ -z $profile ]; then echo "no profile specified"; exit 1; fi

resp=$(aws sts get-caller-identity --profile $temp_profile | jq '.UserId')

if [ ! -z $resp ]; then
    echo '{
        "Version": 1,
        "AccessKeyId": "'"$(aws configure get aws_access_key_id --profile $temp_profile)"'",
        "SecretAccessKey": "'"$(aws configure get aws_secret_access_key --profile $temp_profile)"'",
        "SessionToken": "'"$(aws configure get aws_session_token --profile $temp_profile)"'",
        "Expiration": "'"$(aws configure get expiration --profile $temp_profile)"'"
    }'
    exit 0
fi
read -p "Enter MFA token: " mfa_token

if [ -z $mfa_token ]; then echo "MFA token can't be empty"; exit 1; fi

data=$(aws sts assume-role --role-arn $role \
                    --profile $profile \
                    --role-session-name "$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20)" \
                    --serial-number $mfa_arn \
                    --token-code $mfa_token | jq '.Credentials')

aws_access_key_id=$(echo $data | jq -r '.AccessKeyId')
aws_secret_access_key=$(echo $data | jq -r '.SecretAccessKey')
aws_session_token=$(echo $data | jq -r '.SessionToken')
expiration=$(echo $data | jq -r '.Expiration')

aws configure set aws_access_key_id $aws_access_key_id --profile $temp_profile
aws configure set aws_secret_access_key $aws_secret_access_key --profile $temp_profile
aws configure set aws_session_token $aws_session_token --profile $temp_profile
aws configure set expiration $expiration --profile $temp_profile
aws configure set source_profile $profile --profile $temp_profile

echo '{
  "Version": 1,
  "AccessKeyId": "'"$aws_access_key_id"'",
  "SecretAccessKey": "'"$aws_secret_access_key"'",
  "SessionToken": "'"$aws_session_token"'",
  "Expiration": "'"$expiration"'"
}'
