#!/usr/bin/env bash
set -euo pipefail

ROLE_ARN="arn:aws:iam::578383550493:role/StaleWindowRole"
PROFILE="staleuser"

assume() {
  aws sts assume-role  \
    --role-arn "$ROLE_ARN" \
    --role-session-name test-session-$(date +%s) \
    --profile "$PROFILE"   \
    --output json
}

#  mint creds **first**
CREDS_JSON=$(assume)
export AWS_ACCESS_KEY_ID=$(jq -r .Credentials.AccessKeyId     <<<"$CREDS_JSON")
export AWS_SECRET_ACCESS_KEY=$(jq -r .Credentials.SecretAccessKey <<<"$CREDS_JSON")
export AWS_SESSION_TOKEN=$(jq -r .Credentials.SessionToken    <<<"$CREDS_JSON")

echo " Click  IAM ▶︎ Roles ▶︎ StaleWindowRole ▶︎ Revoke active sessions."
echo "  Press [Enter] the instant click the Revoke button…"
read -r

REVOKE_TS=$(date)
echo " Revoke marked: $REVOKE_TS"
echo " Monitoring access every 1 s…"

start=$(date +%s)
while true; do
  if aws sts get-caller-identity --output text &>/dev/null; then
    sleep 1
  else
    stop=$(date +%s)
    echo " First AccessDenied at: $(date)"
    echo " Stale window: $((stop - start)) seconds"
    exit 0
  fi
done
