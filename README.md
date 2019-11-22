# Quarkus Performance Measurements

Some scripts for memory usage and boot-time measurement.

## Step by Step

1) Modify the **Dockerfile** (look for PROXY) to use a proxy server or not
2) Build the docker image with ```env_build.sh``` or ```env_build.cmd```
3) Run the docker image with ```env_run.sh``` or ```env_run.cmd```
4) Build the demo projects inside docker with ```./build.sh```
5) Display installed java versions using the command ```jabba ls```
6) Switch to one java version using the command ```jabba use zulu@1.8```
7) Run plot-tests with the command ```./plot-test-all.sh MacOS-zulu@1.8```
8) Goto step 6) and switch to an other java version
