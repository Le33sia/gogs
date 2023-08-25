
node('labelforslave') {
    def remoteServer = '10.0.0.35'
    def remotePath = '/home/git/workspace/'
    def sshCredentialsId = '6868900f-c523-4df0-bc9c-e866e20a3630'

    stage('Cleanup') {
        sh 'docker system prune -a --volumes -f'
    }

    stage('Run Docker Compose') {
        sh 'docker compose up -d'
        sleep 15
        sh 'docker ps'
        sh 'docker compose down -v --remove-orphans'
        sh 'docker images'
    }

    stage('Deploy to Ubuntu_Server') {
        withCredentials([sshUserPrivateKey(credentialsId: sshCredentialsId, keyFileVariable: 'KEY_FILE')]) {
            // Copy Docker images to the remote server
            sh "scp -i ${KEY_FILE} mymariadb-image.tar mygogs-image.tar ${remoteServer}:${remotePath}"

            // Copy docker-compose.yml to the remote server
            sh "scp -i ${KEY_FILE} docker-compose.yml ${remoteServer}:${remotePath}"

            // SSH into the remote server and run Docker Compose
            sh "ssh -i ${KEY_FILE} ${remoteServer} \"cd ${remotePath} && docker load -i mymariadb-image.tar && docker load -i mygogs-image.tar && docker compose up -d\""
        }
    }
}
