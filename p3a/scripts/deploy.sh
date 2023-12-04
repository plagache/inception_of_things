#!/bin/bash
REPOURL="https://gitlab.com/3rdn4x3l4/deploy-svc-iot.git"
APPPATH="coolapp"
argocd app create coolapp --repo $REPOURL --path $APPPATH --dest-server https://kubernetes.default.svc --dest-namespace dev
argocd app get coolapp
argocd app set coolapp --sync-policy automated
argocd app sync coolapp

false
while [ "$?" -ne 0 ]; do printf "\rwaiting for $APPPATH to boot up $counter"; ((counter++));sleep 1; kubectl get pods -n dev | grep cool-app | grep Running &> /dev/null; done

printf "\n$APPPATH Runing\n"
