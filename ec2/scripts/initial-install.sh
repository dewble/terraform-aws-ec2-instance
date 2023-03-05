#!/bin/bash
echo "install nginx from apt-get"
sudo apt-get update
sudo apt-get install -y nginx

echo "start amazon-ssm-agent"
sudo snap start amazon-ssm-agent
