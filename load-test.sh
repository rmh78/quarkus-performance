#!/bin/bash
$@ &
MY_PID=$!
N=10000
LAST_TIME=0
FORMAT_STRING="%10s %10s %10s %10s %10s\n"
REAL_TIME_SUM=0
i="1"
ITER=10
sleep 2

while [ $i -lt $(($ITER + 1)) ]
do
  COMMAND="curl -s http://localhost:8080/hello -o /dev/null"
  REAL_TIME=$({ time $COMMAND ; } 2>&1 | grep real | sed -E 's/[^0-9\]+//g' | sed 's/^0*//')
  REAL_TIME_SUM=$(($REAL_TIME_SUM+$REAL_TIME))
  CPU_TIME_TOTAL="$(ps -p $MY_PID -o 'time=' | awk -F'[:.]+' '{t=$3*10+1000*($2+60*$1); print t}')"
  echo $CPU_TIME_TOTAL

  CPU_TIME=$((CPU_TIME_TOTAL - LAST_TIME))
  LAST_TIME=$CPU_TIME_TOTAL
  RSS=$(ps -p $MY_PID -o 'rss=')
  RSS=$(($RSS/1024))
  MEMORY_MS=$(($RSS*$REAL_TIME/1000))
  REQ_PER_S=$(($N*1000/$REAL_TIME))
  REQ_PER_CPUS=$(($N*1000/$CPU_TIME))
  REQ_PER_MBS=$(($N/$MEMORY_MS))
  if [ "$i" -eq "1" ]; then
    printf "$FORMAT_STRING" "n" "cpums" "req/cpus" "rss in mb" "req/mbs";
  fi
  printf "$FORMAT_STRING" $i $CPU_TIME $REQ_PER_CPUS $RSS $REQ_PER_MBS
  i=$[$i+1]
done

echo "end"
MEMORY_MS=$(($RSS*$REAL_TIME_SUM/1000))
REQ_PER_CPUS=$(($ITER*$N*1000/$CPU_TIME_TOTAL))
REQ_PER_MBS=$(($ITER*$N/$MEMORY_MS))
printf "$FORMAT_STRING" "TOTAL" $CPU_TIME_TOTAL $REQ_PER_CPUS $RSS $REQ_PER_MBS
kill -9 $MY_PID
