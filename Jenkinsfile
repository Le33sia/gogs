pipeline {
    agent any
    
    stages {
        stage('Build Gogs Image') {
            steps {
                sh 'docker build -t lesiah/gogs:latest .'
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
                
                    sh 'docker push lesiah/gogs:latest'
            }
        }
    }
 
        stage('Deploy to k8s') {
            steps{
                script{
                    kubernetesDeploy (configs: 'app-deployment.yaml',kubeconfigId: 'k8sconfigpwd')
                }
            }
        }
    }
}


        


        
        
        


        
        
