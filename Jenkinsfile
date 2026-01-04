pipeline {
    agent any

    environment {
        // 1. Your Docker Hub Username
        DOCKERHUB_USERNAME = 'tarun142333'

        IMAGE_NAME = 'my-devops-app'

        // 2. THE NEW KEY ID (Matches what we just created)
        registryCredential = 'my-docker-key'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building Docker Image...'
                sh "docker build -t ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Uploading to Docker Hub...'
                // Using the new key ID
                withCredentials([usernamePassword(credentialsId: registryCredential, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
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