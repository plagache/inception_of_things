#!/bin/bash

#Docker install
sudo apt-get update && \
sudo apt install -y ca-certificates curl apt-transport-https && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
sudo apt-get update && \
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose && \
sudo usermod -aG docker $USER

#kubectl install
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check && \
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#k3d install
rm -f k3d.sh && \
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh > k3d.sh && \
chmod +x k3d.sh
./k3d.sh

#argoCD install
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# sudo cp cert.crt /usr/local/share/ca-certificates
sudo update-ca-certificates
