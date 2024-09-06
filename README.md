# Oriserve Jenkins Pipeline Deployment

This repository contains a Jenkins pipeline that automates the build, packaging, and deployment of the **Oriserve** application. The pipeline fetches the code from GitHub, builds the Java project using Maven, uploads the `.war` file to AWS S3, and deploys it using AWS CodeDeploy.

## Pipeline Overview

The Jenkins pipeline is defined in the `Jenkinsfile` and consists of the following stages:

1. **Checkout**: Retrieves the latest code from the GitHub repository.
2. **Build**: Compiles the code and creates a `.war` file using Maven.
3. **Upload WAR to S3**: Zips the `.war` file and deployment scripts, then uploads the package to an S3 bucket.
4. **Deploy to AWS CodeDeploy**: Creates a deployment in AWS CodeDeploy using the S3 package.

## Pipeline Stages

### 1. Checkout
- The pipeline starts by checking out the source code from the `main` branch of the repository.
- Jenkins uses the following Git command:
  ```groovy
  git url: 'https://github.com/faisalkamilansari/oriserve.git', branch: 'main'
  ```
### 2. Build
- This stage compiles the Java application and packages it as a .war file using Maven.
- The command used is:
  ```groovy
  mvn clean package
  ```
- The generated .war file is placed in the target/ directory.

### 3. Upload WAR to S3
- The pipeline zips the .war file along with appspec.yml and deployment scripts (start_server.sh, stop_server.sh, and remove_old_war.sh).
- It then uploads the zipped package to the specified S3 bucket using the AWS CLI:
  ```groovy
  aws s3 cp deployment-package.zip s3://$S3_BUCKET/deployment-package.zip
  ```
### 4. Deploy to AWS CodeDeploy
- Once the package is uploaded, AWS CodeDeploy is triggered to deploy the application to the EC2 instances in the deployment group.
- The following AWS CLI command is used to create the deployment:
  ```groovy
    aws deploy create-deployment \
    --application-name $APP_NAME \
    --deployment-group-name $DEPLOY_GROUP \
    --s3-location bucket=$S3_BUCKET,key=deployment-package.zip,bundleType=zip \
    --deployment-config-name CodeDeployDefault.AllAtOnce \
    --region $REGION
  ```
### Environment Variables
- The following environment variables are used to configure the pipeline:

| Variable         | Description                                    |
|------------------|------------------------------------------------|
| `DOCKER_CLI`     | Path to Docker CLI (if used).                  |
| `S3_BUCKET`      | Name of the S3 bucket for storing the package. |
| `DEPLOY_GROUP`   | CodeDeploy deployment group name.              |
| `APP_NAME`       | Name of the AWS CodeDeploy application.        |
| `REGION`         | AWS region where CodeDeploy is deployed.       |
| `AWS_CREDENTIALS`| Jenkins credentials ID for AWS access.         |


### Prerequisites

#### 1. Jenkins Setup: Ensure Jenkins has the following plugins:

- AWS Credentials Plugin
- Git Plugin
- Maven Integration Plugin
#### 2. AWS IAM Role: Make sure your IAM role has the following permissions:
- s3:PutObject to upload files to the S3 bucket.
- codedeploy:CreateDeployment to initiate deployments in CodeDeploy.

#### 3. AWS CodeDeploy Configuration:
- Set up an AWS CodeDeploy application (oriserve-app) and a deployment group (grp-oriserve).
