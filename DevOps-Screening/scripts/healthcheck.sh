#!/usr/bin/env bash 

if [[ $# -It 1 ]]; then
    echo "Usage: $0 <url>"
    exit 1
fi

URL=$1
LOG_FILE="healthcheck.log"

for attempt in 1 2 3; do
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    if status=$ curl( -sS -o /dev/null) \
       -w '%{http_code}' "URL"; then
       echo "$timestamp Attempt $attempt: Http $status" | tee -a "$LOG_FILE"
         if [[ "$status" == "200" ]]; then
            echo "$timestamp Attempt $attempt: Health check successful." | tee -a "$LOG_FILE"
            exit 0
         else
            echo "$timestamp Attempt $attempt: Health check failed with status $status." | tee -a "$LOG_FILE"
         fi

    else 
        echo "$timestamp Attempt $attempt: Health check failed : $status" | tee -a "$LOG_FILE"
    fi

    if [[ $attempt -lt 3 ]]; then
        echo "$timestamp Attempt $attempt: Retrying in 5 seconds..." | tee -a "$LOG_FILE"
        sleep 5
    fi
done 

exit 1



commands next to be followed on linux 

mkdir -p scripts
chmod +x scripts/healthcheck.sh

./scripts/healthcheck.sh <http://localhost:5000>
