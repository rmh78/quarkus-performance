#!/bin/bash
echo $@

$1 &
MY_PID=$!
sleep 0.02
psrecord $MY_PID --plot $3 & PSRECORD_PID=$!

# sleep until ready
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' $2)" != "200" ]]; do sleep 0.02; done
echo "##### FIRST SERVED REQUEST #####"

for i in {1..3}
do
    sleep 1
    curl $2
done

kill -9 $MY_PID
echo $(pwd)/$3