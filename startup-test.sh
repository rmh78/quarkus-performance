#!/bin/bash
$@ &
MY_PID=$!
N=1000
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8080/hello)" != "200" ]]; do sleep 0.02; done
CPU_TIME_TOTAL="$(ps -p $MY_PID -o 'time=' | awk -F'[:.]+' '{t=$3*10+1000*($2+60*$1); print t}')"
echo "Total CPU time used: $CPU_TIME_TOTAL ms"
kill -9 $MY_PID