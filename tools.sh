#/bin/bash
set -e

sudo apt update
sudo apt upgrade -y

sudo apt install apt-transport-https ca-certificates gnupg curl python3-dev python3-pip python3-setuptools software-properties-common unzip htop mc -y
sudo pip3 install thefuck

echo installing aws-cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

git clone https://github.com/tfutils/tfenv.git ~/.tfenv
sudo ln -s ~/.tfenv/bin/* /usr/local/bin
which tfenv
tfenv install latest
tfenv use latest

echo Adding apt keys
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

echo Adding apt repositories
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo add-apt-repository --yes --update ppa:ansible/ansible
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

echo installing software
sudo apt update && sudo apt install ansible packer google-cloud-cli -y