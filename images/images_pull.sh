#!/bin/bash
#https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/#config-file
#images=(kube-apiserver-amd64 kube-controller-manager-amd64 kube-scheduler-amd64 kube-proxy-amd64 etcd-amd64 pause-amd64 k8s-dns-sidecar-amd64 k8s-dns-kube-dns-amd64 k8s-dns-dnsmasq-nanny-amd64)
#images=(kube-apiserver-amd64:v1.9.6 kube-controller-manager-amd64:v1.9.6 kube-scheduler-amd64:v1.9.6 kube-proxy-amd64:v1.9.6 etcd-amd64:3.1.11 pause-amd64:3.0 k8s-dns-sidecar-amd64:1.14.7 k8s-dns-kube-dns-amd64:1.14.7 k8s-dns-dnsmasq-nanny-amd64:1.14.7)
#for imageName in ${images[@]} ; do
#  docker pull mirrorgooglecontainers/$imageName
#  docker tag mirrorgooglecontainers/$imageName gcr.io/google_containers/$imageName
#  docker rmi mirrorgooglecontainers/$imageName
#done


##1.10.3
images=(kube-apiserver-amd64:v1.10.3 kube-controller-manager-amd64:v1.10.3 kube-scheduler-amd64:v1.10.3 kube-proxy-amd64:v1.10.3 etcd-amd64:3.1.12 pause-amd64:3.1 k8s-dns-sidecar-amd64:1.14.8 k8s-dns-kube-dns-amd64:1.14.8 k8s-dns-dnsmasq-nanny-amd64:1.14.8)
for imageName in ${images[@]} ; do
  docker pull mirrorgooglecontainers/$imageName
  docker tag mirrorgooglecontainers/$imageName k8s.gcr.io/$imageName
  docker rmi mirrorgooglecontainers/$imageName
done

docker pull quay.io/coreos/flannel:v0.9.1-amd64