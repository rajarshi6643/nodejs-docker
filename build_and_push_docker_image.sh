#!/bin/bash
# Shell script to build a Docker image of the application and push it to the Docker hub registry.
# 'DOCKER_PASSWORD','DOCKER_USERNAME' & 'REPO_NAME'need to be set set as environment variables of the pipeline.

# First build the image
docker build -t anzbank-test-app .
echo "Dcker build success!"

#Login to Dockerhub. 
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
echo "DockerHub login success!"

#Tag the image before pushing it to Docker Hub.
#sudo docker tag anzbank-test-app rajarshih6643/anzbank-test-repo:anzbank-test-app
docker tag anzbank-test-app $DOCKER_USERNAME/$REPO_NAME:anzbank-test-app

#Now, push the image to my Docker hub repository.
#sudo docker push rajarshih6643/anzbank-test-repo:anzbank-test-app
docker push $DOCKER_USERNAME/$REPO_NAME:anzbank-test-app
echo "Pushed the image to dockerhub successfully"