pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'tarun142333'
        IMAGE_NAME = 'my-devops-app'
        // Ensure this ID matches what you have in Jenkins Credentials
        registryCredential = 'my-docker-key'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building Docker Image...'
                // CHANGED: 'sh' to 'bat'
                bat "docker build -t ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Uploading to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: registryCredential, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    // CHANGED: 'sh' to 'bat' and used Windows-style pipe handling
                    bat "echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin"
                    bat "docker push ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Clean Up') {
            steps {
                // CHANGED: 'sh' to 'bat'
                bat "docker rmi ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest"
            }
        }
    }
}