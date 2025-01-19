#!/bin/bash
BTOKEN=$(kubectl get secrets -n user1-ns user1-secret -oyaml |grep token|grep -v 'api'|grep -v type|awk {'print $2'})
export KUBECONFIG=/tmp/user1_conf
kubectl config set-cluster K8sTestServer --server https://192.168.1.100:6443 --certificate-authority=/etc/kubernetes/pki/ca.crt --embed-certs=true
kubectl config set-credentials user1-sa --token=$BTOKEN
kubectl config set-context user1K8s --cluster=K8sTestServer --user=user1-sa --namespace=user1-ns
kubectl config current-context
kubectl config use-context user1K8sContext
kubectl config get-contexts
