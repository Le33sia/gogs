 
pipeline {
    agent any
     environment {
        DOCKER_IMAGE_NAME = 'gogsimage'
        DOCKER_IMAGE_TAG = 'latest'
        SERVER_USERNAME = 'git'
        SERVER_IP = '10.0.0.35'
        SERVER_DESTINATION = '/home/git/'
    }

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
        stage('Deploy to Server') {
            steps {
                script {
                    def remotePath = "${SERVER_USERNAME}@${SERVER_IP}:${SERVER_DESTINATION}"
                    sh "docker save -o gogs.tar ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    sh "scp gogs.tar ${remotePath}"
                    sshagent(['0f367be8-22f6-40db-b382-0debd9a3e609']) {
                        sh "ssh ${remotePath} 'docker load -i gogs.tar'"
                    }
                }
            }
        }
    }
}










     
      //  stage('Deploy to Ubuntu_Server') {
           // steps {
             //   sh 'docker save -o gogsimage.tar gogsimage'  
              //  sh 'scp /home/jenkins/workspace/dockerbuild/gogsimage.tar git@10.0.0.35:/home/git/'
                //sh 'scp /home/jenkins/worksppace/dockerbuild/docker-compose.yml git@10.0.0.35:/home/git/' 
         //   }
        //}
  //  }
//}        

        
       
        


        

