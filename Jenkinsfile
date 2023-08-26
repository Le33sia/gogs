
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
                sh 'scp gogsimage.tar dev@10.0.0.35:/home/git/'
                sh 'scp docker-compose.yml dev@10.0.0.35:/home/git/' 
                     
                }
            }
        }

        stage('Deploy') {
        
            steps {
                script {
                    // Copy the docker-compose.yml and gogsimage.tar files to the remote server
                    sshCommand remote: '10.0.0.35', command: 'mkdir -p /home/git/app/' // Create a directory for deployment
                    sshPut remote: '10.0.0.35', from: 'docker-compose.yml', into: '/home/git/app/'
                    sshPut remote: '10.0.0.35', from: 'gogsimage.tar', into: '/home/git/app/'

                    // SSH into the remote server and execute docker-compose up
                   // sshCommand remote: '10.0.0.35', command: "cd /home/git/app/ && docker-compose up -d"
                }
            }
        }
    }
}



        
        


        

