
pipeline {
    agent any
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
                sh 'scp /home/jenkins/worspace/dockerbuild/gogsimage.tar git@10.0.0.35:/home/git/'
                sh 'scp /home/jenkins/worksppace/dockerbuild/docker-compose.yml git@10.0.0.35:/home/git/' 
            }
        }

        


        
        


        

