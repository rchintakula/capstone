#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath="rchintakula/capstone-project-cloud-devops"

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run capstone-project-cloud-devops --image=$dockerpath --port=80


# Step 3:
# List kubernetes pods
kubectl get pods


# Step 4:
# Forward the container port to a host
kubectl expose deployment capstone-project-cloud-devops --type=LoadBalancer --port=80

# Open the service 
# minikube service capstone-project-cloud-devops