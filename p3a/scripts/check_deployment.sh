#!/bin/bash

APPPATH="coolapp"

argocd app sync coolapp

false
while [ "$?" -ne 0 ]; do printf "\rwaiting for $APPPATH to boot up $counter"; ((counter++));sleep 1; kubectl get pods -n dev | grep cool-app | grep Running &> /dev/null; done

printf "\n$APPPATH Runing\n"

LOCALPORT=4242
CONTAINERPORT=8888

nohup kubectl port-forward svc/cool-app -n dev $LOCALPORT:$CONTAINERPORT > /dev/null 2>&1 &

false
while [ "$?" -ne 0 ]; do sleep 1; curl localhost:$LOCALPORT &> /dev/null; done

curl localhost:$LOCALPORT
