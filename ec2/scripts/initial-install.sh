#!/bin/bash

echo "Starting amazon-ssm-agent"
sudo snap start amazon-ssm-agent

echo "Installing PostgreSQL"
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install -y postgresql-14 postgresql-contrib postgresql-client
sudo su - postgres -c "bash -c '
# Create a new user with ID jeff and password jeff
psql -c \"CREATE ROLE jeff WITH LOGIN PASSWORD '\''jeff'\'' CREATEDB;\"

# Create a new database called jeff-api
createdb jeff-api --owner=jeff
'"

echo "Setting hostname"
sudo hostnamectl set-hostname jeff-instance

echo "Setting locale"
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

echo "Upgrading Python"
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install -y python3.10 python3.10-venv
sudo ln -s /usr/bin/python3.10 /usr/bin/python
python --version

echo "Setting up virtual environment"
mkdir -pv /home/ubuntu/projects /home/ubuntu/venvs
python -m venv /home/ubuntu/venvs/jeff-api
source /home/ubuntu/venvs/jeff-api/bin/activate

echo "Installing Python packages"
pip install wheel fastapi "uvicorn[standard]" sqlalchemy alembic "pydantic[email]" "passlib[bcrypt]" python-multipart "python-jose[cryptography]" gunicorn
