pipeline {
    agent {
        label 'docker-label'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    sh 'docker system prune -a'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests inside the Docker container
                    sh 'docker build -t gogsapp .'
                        
                    }
                }
            }
        }

        
