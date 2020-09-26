#!/bin/sh

# Install the GraalVM enterprise edition
# The bundles for GraalVM and Native Image have to be downloaded from Oracle
# and copied into the director graalvm-ee

export JABBA_HOME="$HOME/.jabba"

jabba() {
    local fd3=$(mktemp /tmp/jabba-fd3.XXXXXX)
    (JABBA_SHELL_INTEGRATION=ON $HOME/.jabba/bin/jabba "$@" 3>| ${fd3})
    local exit_code=$?
    eval $(cat ${fd3})
    rm -f ${fd3}
    return ${exit_code}
}

if [ "$(ls -A /work/graalvm-ee)" ]; then
    echo "install GraalVM EE"
    jabba install graalvm-ee@20.2.0=tgz+file:///work/graalvm-ee/graalvm-ee-java11-linux-amd64-20.2.0.tar.gz
    jabba use graalvm-ee@20.2.0
    gu -L install /work/graalvm-ee/native-image-installable-svm-svmee-java11-linux-amd64-20.2.0.jar
fi