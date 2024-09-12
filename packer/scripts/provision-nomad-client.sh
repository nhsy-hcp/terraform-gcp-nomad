#!/bin/bash
set -e
dnf install -y yum-utils containernetworking-plugins
mkdir /opt/cni
ln -s /usr/libexec/cni /opt/cni/bin
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
systemctl enable docker
