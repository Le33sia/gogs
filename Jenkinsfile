
pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'gogsimage'
        DOCKER_IMAGE_TAG = 'latest'
        SERVER_USERNAME = 'git'
        SERVER_IP = '10.0.0.50'
        REMOTE_DIRECTORY = '/home/git/'
    }
    stages {
        stage('Cleanup') {
            steps {
                sh 'docker system prune -a --volumes -f'
            }
        }

        stage('Building Gogs Image') {
            steps {
                sh 'docker build -t gogsimage .'
                sleep 15
                sh 'docker images'
                sh 'docker compose down -v --remove-orphans'
            }
        }

        stage('Deploy to Ubuntu_Server') {
            steps {
                sh 'docker save -o gogsimage.tar gogsimage'  
                sh 'scp gogsimage.tar git@10.0.0.50:/home/git/'
                sh 'scp docker-compose.yml git@10.0.0.50:/home/git/'
                sh 'ssh git@10.0.0.50 "docker load -i gogsimage.tar" '
            }
        }
    }
}        

        


        
        
