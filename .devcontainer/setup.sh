#!/bin/bash
# This script runs once when the container is created to set up the environment.
# It installs system-level dependencies (like the ODBC driver) and Python packages.

set -e # Exit immediately if a command exits with a non-zero status.

echo "Updating package list and installing prerequisites..."
sudo apt-get update
sudo apt-get install -y curl apt-transport-https

echo "Adding Microsoft ODBC repository..."
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/debian/11/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list

echo "Installing Microsoft ODBC Driver for SQL Server..."
sudo apt-get update
# The 'ACCEPT_EULA' part is crucial for a non-interactive install
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev

echo "Installing Python packages from requirements.txt globally..."
# Use sudo to install packages globally, making executables available system-wide.
sudo pip3 install -r requirements.txt

echo "✅ Environment setup complete!"
