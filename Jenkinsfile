pipeline {
  agent any
  environment {
        DOCKER_IMAGE_NAME = "lesia-gogs-app"
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
    }

  stages {
    stage("verify tooling") {
      steps {
        sh '''
          docker version
          docker info
          docker compose version 
        '''
      }
    }
    stage('Prune Docker data') {
      steps {
        sh 'docker system prune -a --volumes -f'
      }
    }
    stage('Start container') {
      steps {
        script {
                    docker.build(DOCKER_IMAGE_NAME, "./gogs")
                    }
        sh 'docker compose up -d'
        sh 'docker compose ps'
      }
    }
    stage('Run tests against the container') {
      steps {
        sh 'curl http://10.0.0.196:3000/install | jq'
      }
    }
  }
  post {
    always {
      sh 'docker compose down --remove-orphans -v'
      sh 'docker compose ps'
    }
  }
}
