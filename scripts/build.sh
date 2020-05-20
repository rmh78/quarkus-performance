#!/bin/sh

# demo payara simple
cd /work/demo-payara
mvn clean package payara-micro:bundle

# demo payara advanced
cd /work/demo-payara-jpa
mvn clean package payara-micro:bundle

# demo spring-boot simple
cd /work/demo-spring-boot
mvn clean package

# demo spring-boot advanced
cd /work/demo-spring-boot-jpa
mvn clean package

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