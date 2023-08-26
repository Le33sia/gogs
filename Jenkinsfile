
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
                sh 'docker build -t gogsimage .'
                sleep 15
                sh 'docker images'
                sh 'docker compose down -v --remove-orphans'
            }
        }

        stage('Deploy to Ubuntu_Server') {
            steps {
                sh 'docker save -o gogsimage.tar gogsimage'  
                sh 'scp gogsimage.tar dev@10.0.0.50:/home/dev/'
                sh 'scp docker-compose.yml dev@10.0.0.50:/home/dev/' 
                     
                }
            }
        }
    }

        
