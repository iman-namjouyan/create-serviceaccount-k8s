#!/bin/bash

# Get Token From Existing Secret For user1-secret
BTOKEN=$(kubectl get secrets -n user1-ns user1-secret -o yaml | grep token | grep -v 'api' | grep -v type | awk '{print $2}')

# Create Config File
touch /tmp/user1_conf
export KUBECONFIG=/tmp/user1_conf

# K8sTestServer Configs
kubectl config set-cluster K8sTestServer --server https://192.168.1.100:6443 --certificate-authority=/etc/kubernetes/pki/ca.crt --embed-certs=true

# Set Credentials For user1
kubectl config set-credentials user1-sa --token=$BTOKEN

# Set context for user1
kubectl config set-context user1K8s --cluster=K8sTestServer --user=user1-sa --namespace=user1-ns

# Show Current Context
kubectl config current-context

# Using New context
kubectl config use-context user1K8s

# Show contexts
kubectl config get-contexts

logout
