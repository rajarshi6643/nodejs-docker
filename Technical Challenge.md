# Technical Challenge

For this task, please create a GitHub repository where we can review your source code and any configuration required for your project to execute. Please make sure the repository is public.

## Requirements
- Create a simple application which has a `/version` HTTP endpoint.
- Containerise your application as a single deployable artefact, encapsulating all dependencies.
- Provide a manifest(s) suitable for deploying you app to Kubernetes.
- Create a CI/CD pipeline for your application that performs the following:
	1. Builds your app.
	2. Containerises it.
	3. Deploys it to a Kubernetes cluster.

The application can be written in any programming language.

The `version` endpoint shall return the following:

1. Application version. 
2. Application build SHA. 
3. Description.

### API Example Response:

```
{
  "version": "1.0.0",
  "build_sha": "abc57858585",
  "description" : "pre-interview technical test"
}
```
## Bonus Points

Provision the Kubernetes cluster and supporting infrastructure using Terraform (GKE/EKS/AKS). Include your IaC in the repo and incorporate its delivery into your CI/CD pipeline.

## Additional Considerations

-  Create unit tests and/or a test suite that validates your code.
-  Your design/implementation choices should be guided by the principles of simplicity and security.
-  Describe or demonstrate any risks/shortcomings associated with your application/deployment.
-  Provide suitable documentation which explains your application and its deployment steps.