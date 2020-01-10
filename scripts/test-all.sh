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

    # run simple payara-micro test
    /work/scripts/test-single.sh "java -Xmn128M -Xmx512M -jar /work/demo-payara/target/demo-payara-microbundle.jar --noCluster" $DEMO_URL payara-micro-simple-$CURRENT_JAVA "Payara Micro (JAX-RS) via Java Runtime ($CURRENT_JAVA)"
    sleep 2

    # run advanced payara-micro test
    /work/scripts/test-single.sh "java -Xmn128M -Xmx512M -jar /work/demo-payara-jpa/target/demo-payara-microbundle.jar --noCluster" $DEMO_URL payara-micro-advanced-$CURRENT_JAVA "Payara Micro (JAX-RS + JPA) via Java Runtime ($CURRENT_JAVA)"
    sleep 2

    # run simple quarkus-java test
    /work/scripts/test-single.sh "java -Xmn16M -Xmx32M -jar /work/demo-quarkus/target/*-runner.jar" $DEMO_URL quarkus-java-simple-$CURRENT_JAVA "Quarkus (JAX-RS) via Java Runtime ($CURRENT_JAVA)"
    sleep 2

    # run advanced quarkus-java test
    /work/scripts/test-single.sh "java -Xmn16M -Xmx32M -jar /work/demo-quarkus-jpa/target/*-runner.jar" $DEMO_URL quarkus-java-advanced-$CURRENT_JAVA "Quarkus (JAX-RS + JPA) via Java Runtime ($CURRENT_JAVA)"
    sleep 2
done

# run simple quarkus native image test
/work/scripts/test-single.sh "/work/demo-quarkus/target/demo-quarkus-1.0.0-SNAPSHOT-runner -Xmn8M -Xmx128M" $DEMO_URL quarkus-native-simple "Quarkus (JAX-RS) via GraalVM Native Image (19.2.1 CE)"

sleep 2

# run advanced quarkus native image test
/work/scripts/test-single.sh "/work/demo-quarkus-jpa/target/demo-quarkus-jpa-1.0.0-SNAPSHOT-runner -Xmn8M -Xmx128M" $DEMO_URL quarkus-native-advanced "Quarkus (JAX-RS + JPA) via GraalVM Native Image (19.2.1 CE)"