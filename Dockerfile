FROM openjdk:8-jdk-alpine
LABEL maintainer="Fábio Luciano <fabio@naoimporta.com>"

ARG SONAR_SCANNER_VERSION=3.2.0.1227

WORKDIR /opt

ADD files/* /usr/local/bin/

RUN apk add --no-cache --virtual .build-dependencies wget \
    && wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip \
    && unzip -q sonar-scanner-cli-${SONAR_SCANNER_VERSION} && rm sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip \
    && ln -s /opt/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner /usr/local/bin/sonar-scanner \
    && ln -s /opt/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner-debug /usr/local/bin/sonar-scanner-debug \
    && chmod a+x /usr/local/bin/* -R \
    && apk add nodejs && apk del .build-dependencies

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]