
pipeline {
    agent any
    
    stages {
        stage('Cleanup') {
            steps {
                sh 'docker system prune -a --volumes -f'
            }
        }

        stage('Build Gogs Image') {
            steps {
                sh 'docker build -t lesiah/gogs .'
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
                
                    sh 'docker push lesiah/gogs'
            }
        }
    }
} 
        stage('Deploy to k8s'){
            steps{
                script{
                    kubernetesDeploy (configs: 'app-deployment.yaml', kubeconfigId: 'k8sconfigpwd')
                }
            }
        }
    }


        


        
        
