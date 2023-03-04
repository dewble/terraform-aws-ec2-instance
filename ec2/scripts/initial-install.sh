#!/bin/bash
echo "install nginx from apt-get"
sudo apt-get update
sudo apt-get install -y nginx

sudo curl "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb" -o "amazon-ssm-agent.deb"
sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent