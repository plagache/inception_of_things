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

mkdir -p ~/.kube/
k3d cluster create new-cluster
k3d kubeconfig merge new-cluster -d -s

#argoCD install
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

#In another terminal foward
#kubectl port-forward svc/argocd-server -n argocd 8080:443
#Get password
#argocd admin initial-password -n argocd
#Login
#argocd login localhost:8080
#argocd app create coolapp --repo $REPOURL --path coolapp --dest-server https://kubernetes.default.svc --dest-namespace dev
#argocd app get coolapp
#argocd app sync guestbook
