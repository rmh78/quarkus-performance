#!/bin/sh
cd /work/demo-payara
mvn clean package payara-micro:bundle

cd /work/demo-quarkus
mvn clean package -Pnative