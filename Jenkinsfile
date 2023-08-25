def dockerCredentials = '6868900f-c523-4df0-bc9c-e866e20a3630'

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
                sh 'docker compose up -d'
                sleep 15
                sh 'docker ps'
                sh 'docker compose down -v --remove-orphans'
                sh 'docker images'
            }
        }

        stage('Deploy to Ubuntu_Server') {
            steps {
                script {
                    // Copy Docker images to the Ubuntu server
                    sshagent(['dockerCredentials']) {
                        sh 'scp mymariadb-image.tar mygogs-image.tar git@10.0.0.35:/home/git/workspace/'
                    }
                    
                    // Copy docker-compose.yml to the remote server
                    sshagent(['dockerCredentials']) {
                        sh 'scp docker-compose.yml git@10.0.0.35:/home/git/workspace/'
                    }
                    
                    // SSH into the remote server and run Docker Compose
                    sshagent(['dockerCredentials']) {
                        sh 'ssh git@10.0.0.35 "cd /home/git/workspace/ && docker load -i mymariadb-image.tar && docker load -i mygogs-image.tar && docker compose up -d"'
                    }
                }
            }
        }
    }
}

