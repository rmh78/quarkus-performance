#!/bin/bash
echo $@

$1 &
MY_PID=$!
sleep 0.02
psrecord $MY_PID --plot $3 & PSRECORD_PID=$!

# sleep until ready
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' $2)" != "200" ]]; do sleep 0.02; done
CPU_TIME_TOTAL="$(ps -p $MY_PID -o 'time=' | awk -F'[:.]+' '{t=$3*10+1000*($2+60*$1); print t}')"
echo "Total CPU time used: $CPU_TIME_TOTAL ms"

for i in {1..3}
do
    sleep 1
    curl $2
done

kill -9 $MY_PID
echo $(pwd)/$3