#!/bin/bash
LOCALPORT=4242
CONTAINERPORT=8888

nohup kubectl port-forward svc/cool-app -n dev $LOCALPORT:$CONTAINERPORT > /dev/null 2>&1 &

false
while [ "$?" -ne 0 ]; do sleep 1; curl localhost:$LOCALPORT &> /dev/null; done

curl localhost:$LOCALPORT
