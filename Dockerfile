ARG OPENJDK_VERSION='12'

FROM openjdk:${OPENJDK_VERSION}-jdk-oracle
LABEL maintainer="Integr8"

ARG SONAR_SCANNER_VERSION=4.0.0.1744

WORKDIR /opt

ADD files/* /usr/local/bin/

RUN yum install -y wget \
    && wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip \
    && unzip -q sonar-scanner-cli-${SONAR_SCANNER_VERSION} && rm sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip \
    && ln -s /opt/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner /usr/local/bin/sonar-scanner \
    && ln -s /opt/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner-debug /usr/local/bin/sonar-scanner-debug \
    && chmod a+x /usr/local/bin/* -R \
    && yum clean all && rm -rf /var/cache/yum

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
