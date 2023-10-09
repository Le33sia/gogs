pipeline {
    agent any
    environment {
        registry = "906476880257.dkr.ecr.us-east-2.amazonaws.com/my-docker-repo-private"
    }
    
    stages {
        stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry 
        }
      }
    }
        //stage('Build Gogs Image') {
            //steps {
               // sh 'docker build -t lesiah/gogs:0.13 .'
                //sleep 15
                //sh 'docker images'
           // }
        //}
        
        stage('Run Tests') {
            
            steps {
                //sh 'go vet ./...'
                //sh 'go test ./...'
                echo "Testing"
            }
         }
        stage('Pushing to ECR') {
     steps{  
         script {
                sh "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 906476880257.dkr.ecr.us-east-2.amazonaws.com"
                sh "docker push 906476880257.dkr.ecr.us-east-2.amazonaws.com/my-docker-repo-private:latest"
         }
        }
      }
        stage('K8S Deploy') {
      steps{   
          script {
                withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'K8S', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                sh ('kubectl apply -f  mysql-configMap.yaml')
                sleep 5
                sh ('kubectl apply -f  mysql-secret.yaml')
                sleep 5
                sh ('kubectl apply -f  mysql.yaml')
                sleep 10
                sh ('kubectl apply -f  app.deployment.yaml')
            
                }
            }
        }
       }
    }
        
    }
 
        
       
              
        
        


        
        
