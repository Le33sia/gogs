 
pipeline {
    agent any
     environment {
        DOCKER_IMAGE_NAME = 'gogsimage'
       // DOCKER_IMAGE_TAG = 'latest'
        SERVER_USERNAME = 'dev'
        SERVER_IP = '10.0.0.50'
        SERVER_DESTINATION = '/home/dev/'
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
               // sh 'docker compose down -v --remove-orphans'
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    sshagent(['home/jenkins/.ssh/id_rsa']) {
                        def remotePath = "${SERVER_USERNAME}@${SERVER_IP}:${SERVER_DESTINATION}"
                   // sh "scp gogsimage.tar ${remotePath}"
                    //sshagent(['0f367be8-22f6-40db-b382-0debd9a3e609']) {
                    //sh "ssh ${remotePath} 'docker load -i gogsimage.tar'  
                        sh "docker save -o ${DOCKER_IMAGE_NAME}.tar ${DOCKER_IMAGE_NAME}"
                        sh "scp ${DOCKER_IMAGE_NAME}.tar ${remotePath}"
                        sh "ssh ${remotePath} 'docker load -i ${DOCKER_IMAGE_NAME}.tar'"
                    }
                }
            }
        }
    }
}

       // stage('Deploy to Server') {
       //     steps {
       //         script {
       //             def remotePath = "${SERVER_USERNAME}@${SERVER_IP}:${SERVER_DESTINATION}"
                   // sh "scp gogsimage.tar ${remotePath}"
                    //sshagent(['0f367be8-22f6-40db-b382-0debd9a3e609']) {
                    //sh "ssh ${remotePath} 'docker load -i gogsimage.tar'  
        //            sh "docker save -o ${DOCKER_IMAGE_NAME}.tar ${DOCKER_IMAGE_NAME}"
         //           sh "scp ${DOCKER_IMAGE_NAME}.tar ${remotePath}"
         //           sh "ssh ${remotePath} 'docker load -i ${DOCKER_IMAGE_NAME}.tar'"
                    











     
      //  stage('Deploy to Ubuntu_Server') {
           // steps {
             //   sh 'docker save -o gogsimage.tar gogsimage'  
              //  sh 'scp /home/jenkins/workspace/dockerbuild/gogsimage.tar git@10.0.0.35:/home/git/'
                //sh 'scp /home/jenkins/worksppace/dockerbuild/docker-compose.yml git@10.0.0.35:/home/git/' 
         //   }
        //}
  //  }
//}        

        
       
        


        

