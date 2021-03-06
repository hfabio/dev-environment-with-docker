sudo apt-get update && sudo apt install curl git -y

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" -y

sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&

sudo docker run hello-world &&

clear &&

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&

sudo chmod +x /usr/local/bin/docker-compose &&

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose &&

clear &&

echo "Docker and docker compose successfully installed" &&

docker --version &&
docker-compose --version