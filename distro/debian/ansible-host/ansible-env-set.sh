#!/bin/bash

# ansible install in host machine
sudo apt-get update
sudo apt-get install ansible apt-utils --no-install-recommends -y

# ansible execute through chroot
echo "going play"
ansible-playbook -i 'localhost,' -c local ./playbook-main.yml
