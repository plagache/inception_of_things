#!/bin/bash
kubectl create namespace dev
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

argocd admin initial-password -n argocd &> /dev/null
while [ "$?" -ne 0 ]; do printf "\rwaiting for argocd to boot up";sleep 2; argocd admin initial-password -n argocd &> /dev/null; done

argocd admin initial-password -n argocd

printf '\nRun this command in another shell:\n\nkubectl port-forward svc/argocd-server -n argocd 8080:443\n\n to be able to login with:\nargocd login localhost:8080\n\n'

#argocd app create coolapp --repo $REPOURL --path coolapp --dest-server https://kubernetes.default.svc --dest-namespace dev
#argocd app get coolapp
#argocd app sync guestbook
#kubectl port-forward svc/coolapp -n dev 4242:8888
