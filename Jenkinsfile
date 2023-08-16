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
                    def lesia-gogs-image = "my-gogs-image:${env.BUILD_NUMBER}"
                    docker.build(lesia-gogs-image, "-f Dockerfile .")
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
