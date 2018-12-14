#!/bin/sh
set -e

: ${SONARQUBE_URL? "A URL do SonarQube deve ser informada"}

SONARQUBE_OPTIONS=" -Dsonar.host.url=${SONARQUBE_URL}"

# Ignore parameters
if [[ -z $LIQUIBASE_OPTIONS_FROM_FS ]]; then
else
fi

sonar-scanner $SONARQUBE_OPTIONS

