#!/bin/bash
# Shell script to build a Docker image of the application and push it to AWS ECR
# This should be executed in  Linux machine or Amazon EC2 Linux instance ( I used Amazon Linux 2 EC2 instance) 
sudo su
#Now, build the image
docker build -t anzbank-test-app .

#Tag the image before pushing it to Docker Hub. Need to replace repository name, repo name etc. based on which repo you need to login and push the image to/
docker tag anzbank-test-app public.ecr.aws/k0i7z9v1/anz-test-repo:anzbank-test-app

# Get authenticated with ECR repository
aws ecr-public get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin public.ecr.aws/k0i7z9v1/anz-test-repo
#Now, push the image to ECR
docker push public.ecr.aws/k0i7z9v1/anz-test-repo:anzbank-test-app
