#!/bin/sh
./plot-test.sh "java -jar ../quarkus-getting-started/target/*-runner.jar -Xmn16m -Xmx128m" http://localhost:8080/hello myplot-java.png