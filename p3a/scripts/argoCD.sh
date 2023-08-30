#!/bin/bash
kubectl create namespace dev
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

printf "\n"
counter=0
argocd admin initial-password -n argocd &> /dev/null
while [ "$?" -ne 0 ]; do printf "\rwaiting for argocd to boot up $counter"; ((counter++));sleep 1; argocd admin initial-password -n argocd &> /dev/null; done


PASSWORD=$(argocd admin initial-password -n argocd)
printf "\nadmin password:\n$PASSWORD\n"
LOCALPORT=24242
CONTAINERPORT=443
printf "\nRun this command in another shell:\n\nkubectl port-forward svc/argocd-server -n argocd $LOCALPORT:$CONTAINERPORT\n\nto be able to login with:\n\nargocd login localhost:$LOCALPORT --insecure --user admin --password $PASSWORD\n\n"
