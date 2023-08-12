#!/bin/bash
k3d cluster delete --all
k3d cluster create fresh-cluster
k3d kubeconfig merge fresh-cluster -d -s
