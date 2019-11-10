#!/bin/sh
echo $@

$1 &
MY_PID=$!
sleep 0.02
psrecord $MY_PID --plot $3 & PSRECORD_PID=$!
sleep 1

# sleep until ready
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' $2)" != "200" ]]; do sleep .00001; done

for i in {1..3}
do
    sleep 1
    curl $2
done

kill -9 $MY_PID

echo "\n"
echo $(pwd)/$3