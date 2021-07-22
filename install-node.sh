
#nvm install
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# installing node and setting as default
nvm install lts/fermium

# setting as default version
nvm alias default lts/fermium

# create-react-app
npm i -g npm yarn create-react-app