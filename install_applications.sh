#!/bin/bash
# Update package lists
sudo apt-get update -y

# Install Java
sudo apt install openjdk-11-jre-headless -y
sudo java --version

#install git
sudo apt install git -y
git --version

install docker
sudo apt install docker.io -y
sudo systemctl start docker
sudo docker run hello-world
sudo systemctl enable docker
docker --version
sudo usermod -a -G docker $(whoami)
sudo chmod 777 /var/run/docker.sock
sudo systemctl restart docker



# Install nginx
# Use this for your user data (script from the top to bottom)
#install apache2 (ubuntu version)
# sudo apt update -y
# sudo apt install -y nginx
# sudo service nginx start
# sudo systemctl enable nginx
#echo "<h1>Hello World from Raymond Ogbebor. Learning terraform from this instance $(hostname -f)</h1>" > /var/www/html/index.html


sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update 
sudo apt install jenkins 
sudo jenkins --version
sudo systemctl enable jenkins
sudo systemctl start jenkins


#Install Ansible
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt upgrade -y
sudo apt install ansible -y

