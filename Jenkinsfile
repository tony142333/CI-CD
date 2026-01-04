pipeline {
    agent any

    environment {
        // REPLACE THIS with your actual Docker Hub username
        DOCKERHUB_USERNAME = 'your-dockerhub-username'
        IMAGE_NAME = 'my-devops-app'
        // This must match the ID you created in Jenkins Credentials
        registryCredential = 'docker-hub-credentials'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building Docker Image...'
                // Build with the tag: username/image:latest
                sh "docker build -t ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Uploading to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: registryCredential, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    // 1. Log in
                    sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    // 2. Push
                    sh "docker push ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Clean Up') {
            steps {
                // Remove the image from the Jenkins server to save space
                sh "docker rmi ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest"
            }
        }
    }
}