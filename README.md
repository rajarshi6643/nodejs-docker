# anz_tech_challenge_application

Repository containing sample REST API, Dockerfile and AWS EKS deployment manifests, shell script and CI/Cd pipeline files. This page contains information regarding how to build, test and deploy the application named as 'anzbank-test-app'. it also contains **'Additional Considerations'**. It also contains **'risks/shortcomings associated with the application/deployment'**.

# Application description:-

The application is written in Node.js. It exposes a GET API with the URI as '/version'. It uses a npm package named as 'git-last-commit' to get the last commit hash ( Short hash) of the active/default branch of the repository. The application uses express to expose the API. Also, it requires the package 'request' for executing integration tests ( 'request' is a dev dependency).

A sample response of the application or API is shown below:-

```
{
  "version": "1.0.0",
  "build_sha": "abc57858585",
  "description" : "pre-interview technical test"
}

```
## Unit or integration tests:-
The application uses the package mocha-chai ( it is adev dependency) to implement three integration tests. One test case tests if the API response status code ( http status code) is 200. Another test case checks if the value of the version parameter in the API response is '1.0.0'. Another test checks if the description parameter value is equal to the string 'Pre-interview technical test'. All three tests are passing.

## Building the application:-
1. GitLab-CI pipeline has been created for both development branch and main branch. So, whenever a code is pushed to the 'Development' branch a pipeline is triggered. The piepline will also be triggered when we merge code ( or directly push to main branch which should be prevented in real-world projects). Only difference between the pipeline from development branch and that from main branch is, for main branch only the deployment stage will be executed but for development branch only test and build step will be executed.

2. The pipeline (created by .gitlab-ci.yml located at the root directory of the project) has three stages as mentioned below:-
   a. test - this stage will pull the latest code from repo and run integration tests ( using mocha-chai library). 
   b. buildimage -this stage will build a docker image ( based on the Dockerfile located in the project root directory), tag it properly and push the image to docker hub. The pipeline could be customised to push the code to AWS ECR as well.
   c. deploy - This step will only be executed for main branch. In this stage we use a base image where Python 3, aws-cli & kubectl is already installed. This step executes kubectl commands to first crete a namespace called 'technical-test'. Then, it creates a deployment with 2 pods and uses the image of the sample application from DockerHub that was cretaed and pushed on buildimage stage. 

### Pipeline environment variables:-
The following env variables was created so that during execution pipeline can use them to perform certain tasks:-

```
$DOCKER_USERNAME=rajarshih6643
$DOCKER_PASSWORD=***********
$REPO_NAME=anzbank-test-repo
$EKS_CLUSTER_NAME=anz-test-eks-cluster

```

## Additional Considerations
 
### 1. Design/implementation choices:-
a.  Here, I have chosen to deploy the service with 'type: LoadBalancer'.This is because, as part of this test, we are  deploying a single application ( or API), so the above service type will create an external load balancer ( cloud provider's load balancer) and expose the service to the outside world. We would need to create a lister rule in the load balancer so that it can redirect the incoming traffic from port 80 to port 8080 and also do a path redirection from '/' to '/version'. In real world scenario, when we would need to deploy a number of applications or APIs in the EKS cluster, we would need to first create a load balancer (either ALB or NLB) and then we have to deploy an ingress controller ( like nginx ingress controller) as a 'NodePort' service type and select the IP address and port of the ingress controller service as target of the load balancer.

b. We could use only an ingress controller as well without using any cloud provider's load balancer. But, for production  clusters, which are likely to receive substantially large volumes of requests to the deployed application, an external load balancer would be the recommended approach.    

### 2. Any risks/shortcomings associated with my application/deployment:-
a. The deployment could not be tested **end-to-end** due to non-availability of an EKS cluster. EKS cluster has a cost associated with it and that is based on per hour. So, keeping a test EKS cluster up and running for few days or weeks might not be convenient. Having said that, I tested generation of the TF plan and noted that plan was about to create 9 resources. Also, I used similar deployment manifests ( like those used for deployment and service creation) in one of my previous projects and was able to create deployment and service (and namespace) successfully. So, the manifests seem to be fine and they should work.

b. I am relatively new to GitLab - I could probably have used other CI/CD tool. But, I reckon, during the 1st round of interview you informed me that you use GitLab as the DevOps tool in your team/squad. So, I thought it would be good to use this test as an opportunity to create repositories in GitLab and create CI/CD pipelines to deploy the application. In the pipeline , test and image build has been tested successfully. I spent quite a bit of time trying to figure out whether I should install a dedicated runner in my project or use a shared runner. I will keep learning and upskilling myself about Gitlab as I like the tool.

c. Another constraints or shortcoming would be that i have not used an ingress controller for this sample test application. ideally (and for real world applications or APIs) we would need a Load Balancer -> Ingress-controller -> Ingress (routing rules) -> Services running in EKS. I did not get much time to implement those stuff as I had to manage time out of my busy schedule for this assignment/challenge.  
