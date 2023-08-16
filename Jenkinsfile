pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Image') {
            steps {
                script {
                    def customImageName = "my-gogs-image:${env.BUILD_NUMBER}"
                    docker.build(customImageName, "-f Dockerfile .")
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            sh 'docker-compose down'
        }
    }
}
