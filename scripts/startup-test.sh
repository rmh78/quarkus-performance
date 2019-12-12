#!/bin/bash
$@ &
MY_PID=$!
DEMO_URL=http://localhost:8080/hello
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' $DEMO_URL)" != "200" ]]; do sleep 0.02; done
CPU_TIME_TOTAL="$(ps -p $MY_PID -o 'time=' | awk -F'[:.]+' '{t=$3*10+1000*($2+60*$1); print t}')"
echo "Total CPU time used: $CPU_TIME_TOTAL ms"
kill -9 $MY_PID