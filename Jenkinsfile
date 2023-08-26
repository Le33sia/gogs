pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image for the Gogs application
                    docker.build("my-gogs-app")
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests if applicable
                    // You can add your testing commands here
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy using Docker Compose
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            // Clean up resources
            sh 'docker-compose down'
        }
    }
}
