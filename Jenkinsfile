
pipeline {
    agent any
    environment {
        SSH_CREDENTIALS = credentials('git(connection to ubuntu server)')
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Load SSH credentials into an environment variable
                    withCredentials([sshUserPrivateKey(credentialsId: 'git(connection to ubuntu server)', keyFileVariable: 'SSH_PRIVATE_KEY')]) {
                        sh '''
                            echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
                            chmod 600 ~/.ssh/id_rsa
                            ssh-add ~/.ssh/id_rsa
                        '''
                    }
                }
            }        

    
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
                //sh 'scp gogsimage.tar dev@10.0.0.35:/home/git/'
                //sh 'scp docker-compose.yml dev@10.0.0.35:/home/git/' 
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    mkdir -p ~/.ssh
                    chmod 700 ~/.ssh
                    echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
                    chmod 600 ~/.ssh/id_rsa
                    ssh-keyscan -H 10.0.0.35 >> ~/.ssh/known_hosts
                    mkdir -p /home/git/app/
                    scp docker-compose.yml gogsimage.tar dev@10.0.0.35:/home/git/app/
                    # Execute additional commands if needed
                '''
            }
        }
    }
}



        
        


        

