#!/bin/bash
function install_docker_compose() {
  sudo curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

which docker-compose >/dev/null 2>&1
if [[ ! $? -eq 0 ]]; then
  install_docker_compose
fi
