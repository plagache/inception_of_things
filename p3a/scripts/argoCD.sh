#!/bin/bash
kubectl create namespace dev
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

#In another terminal foward
cat 'kubectl port-forward svc/argocd-server -n argocd 8080:443\nin another terminal to access webUI'

sleep 10

#Get password
argocd admin initial-password -n argocd

#Login
argocd login localhost:8080

#argocd app create coolapp --repo $REPOURL --path coolapp --dest-server https://kubernetes.default.svc --dest-namespace dev
#argocd app get coolapp
#argocd app sync guestbook
#kubectl port-forward svc/coolapp -n dev 4242:8888
