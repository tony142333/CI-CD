pipeline {
    agent any

    stages {
        stage('Test Docker Access') {
            steps {
                // 1. Verify Jenkins can see Docker
                sh 'docker --version'
                sh 'docker ps'
            }
        }

        stage('Build Image') {
            steps {
                // 2. Build the actual container
                echo 'Building the Docker Image...'
                sh 'docker build -t my-devops-app .'
            }
        }

        stage('Verify Build') {
            steps {
                // 3. List images to prove it exists
                sh 'docker image ls'
            }
        }
    }
}