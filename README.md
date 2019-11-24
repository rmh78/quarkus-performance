# Comparing the CPU/Memory utilisation of a Quarkus JAX-RS application

Some scripts to measure the CPU and Memory utilisation of JAX-RS appliations.
The performance test runs inside a docker container.

The test uses two demo projects.

* **demo-payara** contains a simple JAX-RS application packaged as uber-jar with Payara Micro application server
* **demo-quarkus** contains a simple Quarkus application packaged as jar and additionally compiled as native image using the GraalVM Native Image

## Prepare and start plot-tests

1) Modify the **Dockerfile** (look for PROXY) to use a proxy server or not
2) Build the docker image with ```env_build.sh``` or ```env_build.cmd```
3) Run the image in a new docker container with ```env_run.sh``` or ```env_run.cmd```
4) Build the demo projects inside the docker container with ```./build.sh```
5) Run plot tests inside the docker container with ```./plot-test-all.sh```

## Test scenario

The **plot-test** consists of the following actions:

* starting the application (simple JAX-RS application)
* start a loop with 3 iterations
  * sleep 1 second
  * send http request using curl to the JAX-RS endpoint

## Plots

All plots are generated on my Notebook inside the running docker container.

Docker Host Machine:

* MacbookPro
* CPU: 2,4 GHz Intel Core i5 (4 cores)
* RAM: 4 GB 1067 MHz DDR3

Docker Engine Configuration:

* CPUs: 2
* Memory: 3 GB

### Quarkus via GraalVM Native Image

![Quarkus via GraalVM Native Image](plots/quarkus-native.png)

### Quarkus via Java Runtime

| | | |
|-|-|-|
| ![](plots/quarkus-java-adopt-openj9@1.8.0-232.png) | ![](plots/quarkus-java-graalvm@19.2.1.png) | ![](plots/quarkus-java-zulu@1.8.232.png) |

### Payara Micro via Java Runtime

| | | |
|-|-|-|
| ![](plots/payara-micro-adopt-openj9@1.8.0-232.png) | ![](plots/payara-micro-graalvm@19.2.1.png) | ![](plots/payara-micro-zulu@1.8.232.png) |

## Used Runtimes, Frameworks and Libraries

* Quarkus - <https://quarkus.io>
* GraalVM - <https://www.graalvm.org>
* OpenJ9 - <https://www.eclipse.org/openj9>
* Zulu OpenJDK - <https://www.azul.com/products/zulu-community>
* Payara Micro - <https://www.payara.fish>
* psrecord - <https://github.com/astrofrog/psrecord>
* psutil - <https://psutil.readthedocs.io>
* matplotlib - <https://matplotlib.org>
* jabba - <https://github.com/shyiko/jabba>
