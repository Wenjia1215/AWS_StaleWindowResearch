#!/bin/bash

BUCKET="stale-window-test-bucket"
PROFILE="tempcreds"
OUTPUT="results.csv"

echo "revocation_time,first_failure_time,duration_seconds" >> "$OUTPUT"

echo "Waiting for you to manually revoke the session in AWS Console..."

# Mark revoke start time
read -p "Press [Enter] the moment you click 'Revoke active sessions'... " 
revoke_time=$(date +%s)
echo "🧨 Revoke time marked: $(date -r $revoke_time)"

# Start polling
echo "Monitoring access every 1s..."
while true; do
    aws s3 ls s3://$BUCKET --profile $PROFILE > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        fail_time=$(date +%s)
        duration=$((fail_time - revoke_time))
        echo "First failure at: $(date -r $fail_time)"
        echo "$revoke_time,$fail_time,$duration" >> "$OUTPUT"
        echo "Logged stale window: $duration seconds"
        break
    fi
    sleep 1
done
