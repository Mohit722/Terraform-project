#!/bin/bash
# Install Apache web server
sudo apt-get update
sudo apt-get install -y apache2

# Create a custom index.html
echo "<html><body><h1>Welcome to the Dev Environment</h1></body></html>" | sudo tee /var/www/html/index.html

# Start Apache service
sudo systemctl start apache2
sudo systemctl enable apache2
