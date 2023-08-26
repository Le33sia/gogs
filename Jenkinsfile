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

        stage('Deploy') {
            steps {
                script {
                    // Deploy using Docker Cloud
                   // docker.image('your-docker-image').inside {
                       // sh 'docker-compose up -d'
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up resources
            script {
                //docker.image('your-docker-image').inside {
                   // sh 'docker-compose down'
                }
            }
        }
    }
}
