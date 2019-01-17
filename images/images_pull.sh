#!/bin/bash

#https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/#config-file

##1.9.6
#images=(kube-apiserver-amd64 kube-controller-manager-amd64 kube-scheduler-amd64 kube-proxy-amd64 etcd-amd64 pause-amd64 k8s-dns-sidecar-amd64 k8s-dns-kube-dns-amd64 k8s-dns-dnsmasq-nanny-amd64)
#images=(kube-apiserver-amd64:v1.9.6 kube-controller-manager-amd64:v1.9.6 kube-scheduler-amd64:v1.9.6 kube-proxy-amd64:v1.9.6 pause-amd64:3.0 k8s-dns-sidecar-amd64:1.14.7 k8s-dns-kube-dns-amd64:1.14.7 k8s-dns-dnsmasq-nanny-amd64:1.14.7)
#for imageName in ${images[@]} ; do
#  docker pull mirrorgooglecontainers/$imageName
#  docker tag mirrorgooglecontainers/$imageName gcr.io/google_containers/$imageName
#  docker rmi mirrorgooglecontainers/$imageName
#done

function pulling() {

    ##1.10.3
    images=(kube-apiserver-amd64:v1.10.3 kube-controller-manager-amd64:v1.10.3 kube-scheduler-amd64:v1.10.3 kube-proxy-amd64:v1.10.3 pause-amd64:3.1 k8s-dns-sidecar-amd64:1.14.8 k8s-dns-kube-dns-amd64:1.14.8 k8s-dns-dnsmasq-nanny-amd64:1.14.8)
    for imageName in ${images[@]} ; do
        docker pull mirrorgooglecontainers/$imageName
        docker tag mirrorgooglecontainers/$imageName k8s.gcr.io/$imageName
        docker rmi mirrorgooglecontainers/$imageName
    done

    # to download kubernetes cni images
    # flannel
    cni=(quay.io/coreos/flannel:v0.9.1-amd64)

    # weave
    # cni=(weaveworks/weave-npc:2.5.0 weaveworks/weave-kube:2.5.0)

    # calico
    # cni=()

    for imageName in ${cni[@]} ; do
        docker pull $imageName
    done

    # save images to location
    # bash ./images_save.sh

}

[ ! -f ./kube-apiserver-amd64.tar ] && pulling
[ ! -f ./kube-controller-manager-amd64.tar ] && pulling
[ ! -f ./kube-scheduler-amd64.tar ] && pulling
[ ! -f ./kube-proxy-amd64.tar ] && pulling
[ ! -f ./pause-amd64.tar ] && pulling
[ ! -f ./k8s-dns-dnsmasq-nanny-amd64.tar ] && pulling
[ ! -f ./k8s-dns-kube-dns-amd64.tar ] && pulling
[ ! -f ./k8s-dns-sidecar-amd64.tar ] && pulling
[ ! -f ./flannel.tar ] && pulling
