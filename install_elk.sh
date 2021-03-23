#!/bin/bash

sudo yum install -y docker git
sudo systemctl start docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo sh -c 'echo vm.max_map_count=262144 >> /etc/sysctl.conf'
sudo sysctl -p
git clone https://github.com/alexandrefimov/ELK-kafka /home/ec2-user/elk/
cd /home/ec2-user/elk
chmod 644 logstash.conf filebeat.yml
sudo chmod 644 /var/log/messages
sudo usermod -aG docker ec2-user
exec sg docker -c 'docker-compose up -d'
