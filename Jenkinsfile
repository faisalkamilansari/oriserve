pipeline {
    agent any

    environment {
        DOCKER_CLI = 'docker'  // Adjust if using a different Docker client path
        S3_BUCKET='faisalkamils3bucket'
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
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]){
                    // Copy the WAR file and the appspec.yml to the S3 bucket
                    sh """
                        zip deployment-package.zip target/*.war appspec.yml scripts/start_server.sh scripts/stop_server.sh scripts/remove_old_war.sh
                        """
                        
                        // Upload the ZIP package to S3
                        sh """
                        aws s3 cp deployment-package.zip s3://${S3_BUCKET}/deployment-package.zip
                        """
                    }
                }
            }
        }
        stage('Deploy to AWS CodeDeploy') {
            steps {
                script {
                    // Create a deployment in AWS CodeDeploy
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]){
                    sh """
                    aws deploy create-deployment \
                    --application-name oriserve-app \
                    --deployment-group-name grp-oriserve \
                    --s3-location bucket=faisalkamils3bucket,key=deployment-package.zip,bundleType=zip\
                    --deployment-config-name CodeDeployDefault.AllAtOnce \
                    --region us-east-1
                    """
                    }
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
