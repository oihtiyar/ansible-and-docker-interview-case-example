sudo yum update -y
sudo yum install -y yum-utils
sudo yum install ansible -y
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker
sudo docker run hello-world
sudo docker network create mongonetwork
sudo yum install python3 -y
sudo pip3 install docker
sudo pip3 install pymongo
sudo pip3 install requests
sudo pip3 install docker-py
sudo docker build -t oimon .
ansible-galaxy collection install community.mongodb -y
mkdir case-a
mkdir case-b
sudo vi ~/.bashrc // buraya dosya içeriğini girmeliyiz tee ile veya echo ile olabilir

source ~/.bashrc
