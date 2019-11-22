FROM registry.access.redhat.com/ubi8/ubi

ENV http_proxy=http://host.docker.internal:3128
ENV https_proxy=${http_proxy}
ENV HTTP_PROXY=${http_proxy}
ENV HTTPS_PROXY=${http_proxy}
ENV NO_PROXY=localhost,127.0.0.1

ENV MAVEN_VERSION=3.6.2 
ENV MAVEN_BASE_URL="https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries" 
ENV MAVEN_TARBALL="apache-maven-${MAVEN_VERSION}-bin.tar.gz" 
ENV MAVEN_HOME=/opt/maven 
ENV M2_HOME=${MAVEN_HOME} 
ENV MAVEN_CONFIG="${MAVEN_HOME}/.m2"

COPY ./config/maven/settings_noproxy.xml /tmp/settings_noproxy.xml
COPY ./config/maven/settings_pxproxy.xml /tmp/settings_pxproxy.xml

RUN curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh \
    && jabba install zulu@1.8 \
    && jabba install adopt-openj9@1.8.0-232 \
    && jabba install graalvm@19.2.1 \
    #&& jabba install graalvm@19.3.0 \
    && jabba use graalvm@19.2.1 \
    #&& jabba use graalvm@19.3.0 \
    && gu install native-image \
    && jabba alias default zulu@1.8 \
    # gcc
    && dnf -y install gcc \
    && dnf -y install gcc glibc-devel zlib-devel \
    # ps
    && dnf -y install procps \
    # python
    && dnf -y install python3 \
    && dnf -y install python3-devel \
    # psrecord
    && pip3 install psrecord \
    && pip3 install matplotlib \
    # maven
    && mkdir -p ${MAVEN_HOME} ${MAVEN_HOME}/ref \
    && curl -o /tmp/${MAVEN_TARBALL} ${MAVEN_BASE_URL}/${MAVEN_TARBALL} \
    && tar -xf /tmp/${MAVEN_TARBALL} -C ${MAVEN_HOME} --strip 1 \
    && ln -s ${MAVEN_HOME}/bin/mvn /usr/bin/mvn \
    && cp /tmp/settings_pxproxy.xml ${MAVEN_HOME}/conf/settings.xml 
    #&& cp /tmp/settings_noproxy.xml ${MAVEN_HOME}/conf/settings.xml 

ENV GRAALVM_HOME=/root/.jabba/jdk/graalvm@19.2.1
#ENV GRAALVM_HOME=/root/.jabba/jdk/graalvm@19.3.0

WORKDIR /work