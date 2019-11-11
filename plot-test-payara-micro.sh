#!/bin/sh
./plot-test.sh "java -Xmn16m -Xmx512m -jar demo-payara/target/demo-payara-microbundle.jar" http://localhost:8080/hello myplot-payara-micro.png