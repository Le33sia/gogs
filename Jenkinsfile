pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'gogsimage'
        DOCKER_IMAGE_TAG = 'latest'
        SERVER_USERNAME = 'dev'
        SERVER_IP = '10.0.0.50'
        REMOTE_DIRECTORY = '/app/'
    }

    stages {
        stage('Cleanup Old Data') {
            steps {
                script {
                    // Delete old data in Docker (e.g., containers, images, volumes)
                    sh 'docker system prune -a --volumes -f'
                }
            }
        }
        stage('Build and Save Image') {
            steps {
                script {
                    // Build your Docker image
                    docker.build "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"

                    // Save the Docker image as a tar file
                    sh "docker save -o ${DOCKER_IMAGE_NAME}_${DOCKER_IMAGE_TAG}.tar ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                }
            }
        }

        stage('Transfer Image') {
            steps {
                script {
                    // Transfer the image tar file to the remote server
                    sshPublisher(
                        publishers: [sshPublisherDesc(
                            configName: 'Prod_Server', // Name of the SSH server configuration
                            transfers: [sshTransfer(
                                sourceFiles: "${DOCKER_IMAGE_NAME}_${DOCKER_IMAGE_TAG}.tar", 
                            
                                remoteDirectory: REMOTE_DIRECTORY // Remote directory
                            )]
                        )]
                    )
                }

            }
        }
    }
}
