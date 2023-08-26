
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
        stage('Deploy') {
            steps {
                script {
                    // Copy the docker-compose.yml and gogsimage.tar files to the remote server
                    sh 'docker save -o gogsimage.tar gogsimage'
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



        


        

