pipeline {
    agent any

    stages {
        stage('Cleanup') {
            steps {
                sh 'docker system prune -a --volumes -f'
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

    post {
        always {
            sh 'docker-compose down -v --remove-orphans'
            sh 'docker images'
        }
    }
}
