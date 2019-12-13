#!/bin/bash

function blink() {
curl -X POST --header "Content-Type:application/json" \
    "$BALENA_SUPERVISOR_ADDRESS/v1/blink?apikey=$BALENA_SUPERVISOR_API_KEY" > /dev/null 2>&1
}

SLEEP="${SLEEP_INTERVAL:-5}"
while true; do
    if dmesg | grep -q "Under-voltage detected\!"; then
        echo "undervoltage detected, blinking"
        blink
    else
        echo "no undervoltage detected"
    fi
    echo "sleeping ${SLEEP}"

    sleep "${SLEEP}"
done
