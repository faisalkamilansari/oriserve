pipeline {
    agent any

    environment {
        DOCKER_CLI = 'docker'  // Adjust if using a different Docker client path
        S3_BUCKET='faisals3bucket'
        DEPLOY_GROUP = 'grp-oriserve'
        APP_NAME = 'oriserve-app'
        REGION = 'us-east-1'
        AWS_CREDENTIALS = 'aws-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from the repository
                git url: 'https://github.com/faisalkamilansari/oriserve.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                // Compile and package the application using Maven
                sh "mvn clean package"
            }
        }
        stage('Upload WAR to S3') {
            steps {
                script {
                    withAWS(credentials: 'aws-credentials-id') {
                    // Copy the WAR file and the appspec.yml to the S3 bucket
                    sh """
                    aws s3 cp target/*.war s3://${S3_BUCKET}/calc.war
                    aws s3 cp appspec.yml s3://${S3_BUCKET}/appspec.yml
                    """
                    }
                }
            }
        }
        stage('Deploy to AWS CodeDeploy') {
            steps {
                script {
                    // Create a deployment in AWS CodeDeploy
                    sh """
                    aws deploy create-deployment \
                        --application-name ${APP_NAME} \
                        --deployment-group-name ${DEPLOY_GROUP} \
                        --revision revisionType=S3,s3Location={bucket=${S3_BUCKET},key=your-application.war,bundleType=zip} \
                        --deployment-config-name CodeDeployDefault.AllAtOnce \
                        --region ${REGION}
                    """
                }
            }
        }

    }

    post {
        always {
            // Clean up workspace after the build
            cleanWs()
        }
        success {
            // Notify on successful build and deployment
            echo 'Deployment completed successfully!'
        }
        failure {
            // Notify on failure
            echo 'Deployment failed!'
        }
    }
}
