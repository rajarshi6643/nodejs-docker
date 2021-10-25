#!/bin/bash
sudo su

#Create a namespace named as 'technical-test' where the service will be deployed.
kubectl create namespace technical-test
kubectl get namespaces

#Now execute the deployment manifest to deploy the application in the EKS cluster
kubectl apply -f deployment.yml

#Now deploy the service as type:LoadBalancer so that it can provision a load balancer
# In the load balancer we would need to create a listener rule to redirect traffic reaching at port 80 to port 8080 
# and with URL rewriting as '/version'
kubectl apply -f loadbalancer_service.yml