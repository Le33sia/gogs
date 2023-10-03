pipeline {
    agent any
    environment {
        SERVER_IP = '10.0.0.206'
    }
    
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
                sh '''
                ssh lesia@10.0.0.206 "cd /home/lesia/gogs && kubectl apply -f app-deployment.yaml"
                '''  
                
            }
          }
      }
    }
  
        
       
              
        
        


        
        
