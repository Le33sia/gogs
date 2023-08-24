pipeline {
    agent any

    stages {
        stage('Cleanup') {
            steps {
                script {
                    sh 'docker system prune -a --volumes -f'
                }
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
                script {
                    sh 'docker-compose up -d'
                    sleep 10 // Wait for a few seconds for containers to start
                    sh 'docker ps'
                    sh 'docker images'
                }
            }
        }
    }

    post {
        always {
            script {
                // Cleanup and other post-build tasks
            }
        }
    }
}


