#!/bin/bash
kubectl create namespace dev
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

printf "\n"
counter=0
false
while [ "$?" -ne 0 ]; do printf "\rwaiting for argocd to boot up $counter"; ((counter++));sleep 1; argocd admin initial-password -n argocd &> /dev/null; done


PASSWORD=$(argocd admin initial-password -n argocd | head -n 1)
printf "\nadmin password:\n$PASSWORD\n"
LOCALPORT=24242
CONTAINERPORT=443

nohup kubectl port-forward svc/argocd-server -n argocd $LOCALPORT:$CONTAINERPORT > /dev/null 2>&1 &

sleep 5 ;argocd login localhost:$LOCALPORT --insecure --username admin --password $PASSWORD; sleep 5
