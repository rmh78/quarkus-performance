# Comparing the CPU/Memory utilisation of a JAX-RS application (Quarkus, Payara Micro)

Some scripts to measure the CPU and Memory utilisation of JAX-RS appliations.
The performance test runs inside a docker container.

The test uses four demo projects.

* **demo-payara** contains a simple JAX-RS application packaged as uber-jar with **Payara Micro (5.201)** application server
* **demo-payara-jpa** contains an advanced JAX-RS, JSON-B, CDI, JPA, PostgresDB application packaged as uber-jar with **Payara Micro (5.201)** application server
* **demo-quarkus** contains a simple **Quarkus (1.3.0)** application packaged as jar and additionally compiled as native image using the GraalVM Native Image
* **demo-quarkus-jpa** contains an advanced JAX-RS, JSON-B, CDI, JPA, PostgresDB **Quarkus (1.3.0)** application packaged as jar and additionally compiled as native image using the GraalVM Native Image

## **(1) Prepare and start plot-tests**

1) Modify the **Dockerfile** (look for PROXY) to use a proxy server or not
2) Build the docker image with ```env_build.sh``` or ```env_build.cmd```
3) Run the image in a new docker container with ```env_run.sh``` or ```env_run.cmd```
4) Build the demo projects inside the docker container with ```./scripts/build.sh```
5) Run the tests inside the docker container with ```./scripts/test-all.sh```
6) Plots are generated to directory ```plots```
7) Logs are generated to directory ```logs```

## **(2) Test scenario**

The **plot-test** consists of the following actions:

* starting the application (simple JAX-RS application)
* wait until the first http request to the JAX-RS endpoint can be served (time to first request)
* sleep 1 second
* start load-test using apache benchmarking tool 
  * requests: 5000
  * concurrency: 5
  * url: the JAX-RS endpoint of the application

## **(3) Plots**

All plots are generated on my Notebook inside the running docker container.

Docker Host Machine:

* CPU: Intel i7-8650U 1.90GHz (8 cores)
* RAM: 16GB

Docker Engine Configuration:

* CPUs: 4
* Memory: 8 GB

### **(3.1) Quarkus via GraalVM Native Image**

| Simple Demo (JAX-RS)                 | Advanced Demo (JAX-RS, JSON-B, CDI, JPA, PostgresDB) |
| ------------------------------------ | ---------------------------------------------------- |
| ![](plots/quarkus-native-simple.png) | ![](plots/quarkus-native-advanced.png)               |

### **(3.2) Quarkus via Java Runtime**

|                   Simple Demo (JAX-RS)                    | Advanced Demo (JAX-RS, JSON-B, CDI, JPA, PostgresDB)        |
| --------------------------------------------------------- | ----------------------------------------------------------- |
| ![](plots/quarkus-java-simple-zulu@1.11.0.png)           | ![](plots/quarkus-java-advanced-zulu@1.11.0.png)           |

### **(3.3) Payara Micro via Java Runtime**

| Simple Demo (JAX-RS)                                      | Advanced Demo (JAX-RS, JSON-B, CDI, JPA, PostgresDB)        |
| --------------------------------------------------------- | ----------------------------------------------------------- |
| ![](plots/payara-micro-simple-zulu@1.11.0.png)           | ![](plots/payara-micro-advanced-zulu@1.11.0.png)           |

## **(4) Used Runtimes, Frameworks and Libraries**

* Quarkus - <https://quarkus.io>
* GraalVM - <https://www.graalvm.org>
* OpenJ9 - <https://www.eclipse.org/openj9>
* OpenJDK RI - <https://jdk.java.net/java-se-ri/8>
* Adopt OpenJDK - <https://adoptopenjdk.net/>
* Zulu OpenJDK - <https://www.azul.com/products/zulu-community>
* Payara Micro - <https://www.payara.fish>
* psrecord - <https://github.com/astrofrog/psrecord>
* psutil - <https://psutil.readthedocs.io>
* matplotlib - <https://matplotlib.org>
* jabba - <https://github.com/shyiko/jabba>
* Apache Benchmarking Tool - <https://httpd.apache.org/docs/2.4/programs/ab.html>
