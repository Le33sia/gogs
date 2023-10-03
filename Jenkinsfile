pipeline {
    agent any
    
    stages {
        stage('Build Gogs Image') {
            steps {
                sh 'docker build -t lesiah/gogs:0.14 .'
                sleep 15
                sh 'docker images'
            }
        }
        stage('Run Tests') {
            
            steps {
                //sh 'go vet ./...'
                //sh 'go test ./...'
                echo "Testing"
            }
        }
        stage('Deploy to DockerHub') {
            steps {
                script{
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u lesiah -p ${dockerhubpwd}'
    
}
                
                    sh 'docker push lesiah/gogs:0.14'
            }
        }
    }
 
        stage('Deploy App on k8s') {
      steps {
            sshagent(['k8s']) {
            sh "scp -o StrictHostKeyChecking=no app-deployment.yaml lesia@10.0.0.206:/home/lesia/gogs"
            script {
                try{
                    sh "ssh lesia@10.0.0.206 kubectl create -f ."
                }catch(error){
                    sh "ssh lesia@10.0.0.206 kubectl create -f ."
                }
            }
          }
      }
    }
  }
}        
       
              
        
        


        
        
