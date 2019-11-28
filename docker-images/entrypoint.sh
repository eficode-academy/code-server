#!/bin/bash

if [[ ${GIT_REPO} != "" ]]; then
    git clone --depth 5 ${GIT_REPO} /home/coder/gitclone
    mv /home/coder/gitclone/${GIT_SUBDIR}/* /home/coder/project
fi

if [[ -z "${CODE_PORT}" ]]; then
    CODE_PORT=8080
fi

if [[ "${SECURE}" == "true" ]]; then
  if [[ -z "${SSL_LOCATION}" ]]; then
    SECURE_PARAM="--cert"
  else
    SECURE_PARAM="--cert $SSL_LOCATION"
  fi
fi


sudo chown $(id -u):$(id -g) /var/run/docker.sock

exec code-server ${SECURE_PARAM} --host=0.0.0.0 --port=${CODE_PORT} --auth=password --disable-telemetry
