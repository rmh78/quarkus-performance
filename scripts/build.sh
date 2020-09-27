#!/bin/sh

# demo payara simple
cd /work/demo-payara
mvn clean package payara-micro:bundle

# demo payara advanced
cd /work/demo-payara-jpa
mvn clean package payara-micro:bundle

# demo spring-boot simple
cd /work/demo-spring-boot
mvn package
mvn package -Pnative
mv /work/demo-spring-boot/target/de.harald.test.demospringboot.demospringbootapplication /work/demo-spring-boot/target/demo-ce

# demo spring-boot advanced
cd /work/demo-spring-boot-jpa
mvn package
mvn package -Pnative
mv /work/demo-spring-boot-jpa/target/de.harald.test.demospringboot.demospringbootapplication /work/demo-spring-boot-jpa/target/demo-ce

# demo quarkus simple
cd /work/demo-quarkus
mvn package
mvn package -Pnative
mv /work/demo-quarkus/target/demo-quarkus-1.0.0-SNAPSHOT-runner /work/demo-quarkus/target/demo-ce

# demo quarkus advanced
cd /work/demo-quarkus-jpa
mvn package
mvn package -Pnative
mv /work/demo-quarkus-jpa/target/demo-quarkus-jpa-1.0.0-SNAPSHOT-runner /work/demo-quarkus-jpa/target/demo-ce