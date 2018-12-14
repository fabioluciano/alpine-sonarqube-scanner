FROM openjdk:8-jdk-alpine
LABEL maintainer="Fábio Luciano"
ARG SONAR_SCANNER_VERSION=3.2.0.1227

WORKDIR /opt

ADD entrypoint.sh /usr/local/bin/

RUN apk add --no-cache wget nodejs \
    && wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip \
    && unzip -q sonar-scanner-cli-${SONAR_SCANNER_VERSION} \
    && ln -s /opt/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner /usr/local/bin/sonar-scanner \
    && ln -s /opt/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner-debug /usr/local/bin/sonar-scanner-debug \
    && chmod a+x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]