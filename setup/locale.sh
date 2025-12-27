#!/usr/bin/env bash

set -e

# Enable British English locale
sudo sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

echo "British English locale enabled!"
