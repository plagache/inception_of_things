#!/bin/bash
REPOURL="https://gitlab.com/3rdn4x3l4/deploy-svc-iot.git"
APPPATH="coolapp"
argocd app create coolapp --repo $REPOURL --path $APPPATH --dest-server https://kubernetes.default.svc --dest-namespace dev
argocd app get coolapp
argocd app sync coolapp

printf "\nNOT runing yet\n"
while [ "$?" -ne 0 ]; do printf "\rwaiting for $APPPATH to boot up $counter"; ((counter++));sleep 1; kubectl get pods -n dev | grep cool-app | grep Running; done

printf "\nRuning\n"
LOCALPORT=4242
CONTAINERPORT=8888
printf "\nRun this command in another shell:\n\nkubectl port-forward svc/cool-app -n dev $LOCALPORT:$CONTAINERPORT\n\nto be able to connect to the app with:\n\ncurl localhost:$LOCALPORT\n\n"
