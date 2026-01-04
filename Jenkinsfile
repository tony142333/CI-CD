pipeline {
    agent any

    environment {
        // 1. I updated this to match your Git username.
        // If your Docker Hub user is different, change 'tony142333'
        DOCKERHUB_USERNAME = 'tarun142333'

        IMAGE_NAME = 'my-devops-app'

        // 2. CHECK THIS: This must match the "ID" column in Jenkins Credentials exactly.
        // Common names: 'docker-hub', 'docker-hub-credentials', 'docker-login'
        registryCredential = 'tarun142333'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building Docker Image...'
                // Builds image as: tony142333/my-devops-app:latest
                sh "docker build -t ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Uploading to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: registryCredential, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    // Login and Push
                    sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    sh "docker push ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Clean Up') {
            steps {
                sh "docker rmi ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest"
            }
        }
    }
}