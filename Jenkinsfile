pipeline {
    agent any

    environment {
        // Define environment variables for Maven, SonarQube, and Artifactory
        // MAVEN_HOME = tool name: 'Maven 3.8.1', type: 'Maven'
        SONARQUBE_SERVER = 'SonarQube-Server'  // Replace with your SonarQube server ID
        ARTIFACTORY_SERVER = 'Artifactory'  // Replace with your Artifactory server ID
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
                bat "cd calc && mvn clean install"
            }
        }
        stage('SonarQube Analysis'){
            steps
                {
                    withSonarQubeEnv(SONARQUBE_SERVER) {
                    bat "cd calc && mvn clean verify sonar:sonar -Dsonar.projectKey=Jenkins-tomcat-deployment"
                    }
                }
        }
        // stage('Code Analysis') {
        //     steps {
        //         // Run SonarQube analysis
        //         withSonarQubeEnv(SONARQUBE_SERVER) {
        //             bat "cd calc && mvn sonar:sonar"
        //         }
        //     }
        // }

        // stage('Upload to Artifactory') {
        //     steps {
        //         // Upload the packaged application to Artifactory
        //         script {
        //             def server = Artifactory.server(ARTIFACTORY_SERVER)
        //             def uploadSpec = """{
        //                 "files": [{
        //                     "pattern": "target/*.war",
        //                     "target": "libs-release-local/${env.JOB_NAME}/${env.BUILD_NUMBER}/"
        //                 }]
        //             }"""
        //             server.upload(uploadSpec)
        //         }
        //Tomcat9     }
        // }

        stage('Deploy to Tomcat') {
            steps {
                // Deploy to the appropriate Tomcat environment based on the input parameter
                    script {
                        def tomcatServiceName = 'Tomcat9'
                        def tomcatDir = 'C:\\Program Files (x86)\\Apache Software Foundation\\Tomcat 9.0\\webapps'
                        def warFile = "C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Jenkins-tomcat-deployment\\calc\\target\\web-calculator.war"
                        def destFile = "${tomcatDir}\\web-calculator.war"

                        bat """
                            if exist "${destFile}" del /q "${destFile}"
                            copy "${warFile}" "${destFile}"
                            
                            echo Stopping Tomcat service...
                                net stop ${tomcatServiceName}

                                echo Waiting for Tomcat to stop...
                                timeout /t 20 /nobreak

                                echo Starting Tomcat service...
                                net start ${tomcatServiceName}
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
