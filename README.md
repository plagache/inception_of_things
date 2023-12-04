# Inception Of Things

## Getting started

### Setup VM

- [x] installation with libvirt/qemu
- [x] updating the VM:
```bash
sudo apt update && sudo apt upgrade -y
```
- [x] installing various utility:
```bash
sudo apt install -y git curl make vim ripgrep fd-find
```

- [ ] draw schemas of sandbox for each part

---

### Part 1


![p1_schemas](/images/p1.png)

```bash
ip a
```

```bash
kubectl get nodes -o wide
```

---


### Part 2


```bash
kubectl get all
```

```bash
curl -H "Host:app1.com" 192.168.56.110
```

```bash
curl -H "Host:app2.com" 192.168.56.110
```

```bash
curl 192.168.56.110
```

---

### Part 3

- install  Docker, kubectl, k3d, argoCD: `./install.sh`
- reload k3d clusters: `./reload-cluster.sh`
- create namespace, login in argoCD: `./argoCD.sh`
- deploy the application with argoCD: `./deploy.sh`
- we can now check wich application is running with: `./check_deployment.sh`

```bash
kubectl get all -n dev
```

```bash
kubectl get pods -n dev
```

---

