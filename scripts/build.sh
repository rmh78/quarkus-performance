#!/bin/sh

# demo payara simple
cd /work/demo-payara
mvn clean package payara-micro:bundle

# demo payara advanced
cd /work/demo-payara-jpa
mvn clean package payara-micro:bundle

# demo quarkus simple
cd /work/demo-quarkus
mvn clean package
mvn package -Pnative

# demo quarkus advanced
cd /work/demo-quarkus-jpa
mvn clean package
mvn package -Pnative