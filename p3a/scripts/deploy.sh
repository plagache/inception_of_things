#!/bin/bash
REPOURL="https://gitlab.com/3rdn4x3l4/deploy-svc-iot.git"
APPPATH="coolapp"
argocd app create coolapp --repo $REPOURL --path $APPPATH --dest-server https://kubernetes.default.svc --dest-namespace dev
argocd app get coolapp
argocd app sync coolapp
printf '\nRun this command in another shell:\n\nkubectl port-forward svc/coolapp -n dev 4242:8888\n\nto be able to connect to the app with:\n\ncurl localhost:4242\n\n'
