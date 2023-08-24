pipeline {
    agent any

    stages {
        stage('Cleanup') {
            steps {
                sh 'docker system prune -a --volumes -f'
            }
        }

        stage('Build MariaDB Image') {
            steps {
                script {
                    def mariadbImage = docker.build("mymariadb-image", "-f Dockerfile.mariadb .")
                }
            }
        }

        stage('Build Gogs Image') {
            steps {
                script {
                    def gogsImage = docker.build("mygogs-image", "-f Dockerfile.gogs .")
                }
            }
        }

        stage('Run Docker Compose') {
            steps {
                sh 'docker-compose up -d'
                sleep 10
                sh 'docker ps'
                sh 'docker images'
            }
        }
    }
}
