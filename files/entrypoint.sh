#!/bin/sh
set -e

export SOURCE_PATH='/opt/source'

: ${SONARQUBE_URL? "A URL do SonarQube deve ser informada"}
: ${SONARQUBE_SETTINGS_FILE:='sonar-project.properties'}

if [[ ! -f "${SOURCE_PATH}/${SONARQUBE_SETTINGS_FILE}" ]]; then
    echo -e "O arquivo ${SONARQUBE_SETTINGS_FILE} não foi encontrado no diretório de fontes do projeto!"
    exit 0
fi

SONARQUBE_OPTIONS=" -Dsonar.host.url=${SONARQUBE_URL}"
SONARQUBE_OPTIONS="${SONARQUBE_OPTIONS} -Dproject.settings=${SOURCE_PATH}/${SONARQUBE_SETTINGS_FILE}"

if [[ ! -z "${SONARQUBE_BASE_DIR}" ]]; then
    SONARQUBE_OPTIONS="${SONARQUBE_OPTIONS} -Dsonar.projectBaseDir=${SOURCE_PATH}/${SONARQUBE_BASE_DIR}"
else 
    SONARQUBE_OPTIONS="${SONARQUBE_OPTIONS} -Dsonar.projectBaseDir=${SOURCE_PATH}"
fi

if [[ ! -z "${SONARQUBE_BASE_DIR}" ]]; then
    SONARQUBE_OPTIONS="${SONARQUBE_OPTIONS} -Dsonar.scm.provider=${SONARQUBE_SCM_PROVIDER}"
fi

sonar-scanner $SONARQUBE_OPTIONS