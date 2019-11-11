#!/bin/sh
./plot-test.sh "java -Xmn16m -Xmx32m -jar demo-quarkus/target/*-runner.jar" http://localhost:8080/hello myplot-java.png