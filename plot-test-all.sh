#!/bin/bash

mkdir -p plots/$1

./plot-test.sh "java -Xmn128M -Xmx512M -jar demo-payara/target/demo-payara-microbundle.jar" http://localhost:8080/hello plots/$1/plot-payara-micro.png
sleep 2

./plot-test.sh "java -Xmn16M -Xmx32M -jar demo-quarkus/target/*-runner.jar" http://localhost:8080/hello plots/$1/plot-quarkus-java.png
sleep 2

./plot-test.sh "demo-quarkus/target/demo-quarkus-1.0.0-SNAPSHOT-runner -Xmn8M -Xmx128M" http://localhost:8080/hello plots/$1/plot-quarkus-native.png
sleep 2

: ${1?"Usage: $0 <ENVIRONMENT_NAME>"}