#!/bin/bash

publish_to_maven() {

    GITHUB_TOKEN=vvv
    GITHUB_REPOSITORY=https://maven.pkg.github.com/affinityproject/common-check-widget-backend-lib
    GITHUB_REPOSITORY=$(echo "${GITHUB_REPOSITORY:-}" | tr '[:upper:]' '[:lower:]')

    cd "${1:-}" || exit

    pom="$(find * -name "*.pom")"
    jar="${pom/.pom/.jar}"

    upload "${jar}"
    upload "${pom}"

}

upload() {
  local file="$1"
  local cmd

  cmd=(curl -X PUT)
  cmd+=("https://maven.pkg.github.com/${GITHUB_REPOSITORY:-}/${file}")
  cmd+=(-H "'Authorization: token ${GITHUB_TOKEN:-}'")
  cmd+=(--upload-file "${file}" --fail --silent --show-error)
  cmd+=(-vvv)

  print $cmd
  

  eval "${cmd[@]}" || exit
}