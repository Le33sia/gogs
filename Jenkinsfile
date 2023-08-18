pipeline {
    agent any

    stages {
        stage('Build and Deploy') {
            steps {
                script {
                    def composeFile = 'docker-compose.yml'
                    sh "docker-compose -f ${composeFile} build"
                    sh "docker-compose -f ${composeFile} up -d"
                }
            }
        }
    }
}
