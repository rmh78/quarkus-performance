#!/bin/bash

export JABBA_HOME="$HOME/.jabba"

jabba() {
    local fd3=$(mktemp /tmp/jabba-fd3.XXXXXX)
    (JABBA_SHELL_INTEGRATION=ON $HOME/.jabba/bin/jabba "$@" 3>| ${fd3})
    local exit_code=$?
    eval $(cat ${fd3})
    rm -f ${fd3}
    return ${exit_code}
}

DEMO_URL=http://localhost:8080/hello

# iterate over all installed java version
jabba ls | while read CURRENT_JAVA; do

    jabba use $CURRENT_JAVA
    echo $(java -version)

    # run payara-micro test
    ./plot-test.sh "java -Xmn128M -Xmx512M -jar demo-payara/target/demo-payara-microbundle.jar --noCluster" $DEMO_URL payara-micro-$CURRENT_JAVA "Payara Micro (5.193) via Java Runtime ($CURRENT_JAVA)"
    sleep 2

    # run quarkus-java test
    ./plot-test.sh "java -Xmn16M -Xmx32M -jar demo-quarkus/target/demo-quarkus-1.0.0-SNAPSHOT-native-image-source-jar/*-runner.jar" $DEMO_URL quarkus-java-$CURRENT_JAVA "Quarkus (1.0.0.CR2) via Java Runtime ($CURRENT_JAVA)"
    sleep 2
done

# run quarkus native image test
./plot-test.sh "demo-quarkus/target/demo-quarkus-1.0.0-SNAPSHOT-runner -Xmn8M -Xmx128M" $DEMO_URL quarkus-native "Quarkus (1.0.0.CR2) via GraalVM Native Image (19.2.1 CE)"