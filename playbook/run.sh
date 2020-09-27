#!/bin/bash

docker run --rm -it -v $(pwd)/:/playbook --network=host \
    -w="/playbook" \
    ansible/ansible-runner:1.4.6 \
    ansible-playbook site.yml $@
