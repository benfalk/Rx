#!/bin/bash
curl -O https://raw.githubusercontent.com/spawngrid/kerl/master/kerl
chmod 775 kerl
sudo chown root:root kerl
sudo mv kerl /usr/bin
