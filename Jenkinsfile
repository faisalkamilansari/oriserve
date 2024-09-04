pipeline {
    agent any

    environment {
        DOCKER_CLI = 'docker'  // Adjust if using a different Docker client path
        DOCKER_HUB_CREDENTIALS = 'DockerHub_Cred'  // Replace with your credentials ID
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
        
        stage('Build Docker Image') {
            steps {
                docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS}") {
                        // Build the Docker image
                        sh "docker build -t faisalkamil/oriserve:latest ."
                        
                        // Push the Docker image
                        sh "docker push faisalkamil/oriserve:latest"
                    }
                
                
                }
            }

        stage('Docker Cleanup') {
            steps {
                // Remove old Docker images
                sh """
                docker image prune -a -f
                docker system prune -a -f
                """
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
