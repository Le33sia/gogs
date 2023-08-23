pipeline {
    agent any
    environment {
        GOGS_IMAGE = "my-gogs-image"
        POSTGRES_IMAGE = "my-postgres-image"
        DOCKER_COMPOSE_FILE = "docker-compose.yml"

    }

    
    stages {
        stage('Build and Deploy') {
            steps {
                script {
                    // Build and deploy using Docker Compose
                    sh 'docker system prune -a --volumes -f'

                    sh "docker-compose up -d"
                    sh "docker save -o my-gogs-image.tar my-gogs-image"
                    sh "docker save -o my-postgres-image.tar my-postgres-image"
                    
                    // Transfer files to the remote server
                    sshPublisher(
                        publishers: [
                            sshPublisherDesc(
                                configName: 'cred_docker', // Configure SSH credentials in Jenkins
                                transfers: [
                                    sshTransfer(
                                        sourceFiles: "docker-compose.yml",
                                        remoteDirectory: "/home/git/workspace/"
                                    ),
                                    sshTransfer(
                                        sourceFiles: "my-gogs-image.tar",
                                        remoteDirectory: "/home/git/workspace/"
                                    ),
                                    sshTransfer(
                                        sourceFiles: "my-postgres-image.tar",
                                        remoteDirectory: "/home/git/workspace/"
                                    )
                                ]
                            )
                        ],
                        continueOnError: true
                    )
                    
                    // SSH into the remote server and deploy using Docker Compose
                    sshCommand(
                        remote: 'my-ssh-config',
                        command: "cd /home/git/workspace/ && docker-compose up -d"
                    )
                }
            }
        }
    }
}

            
