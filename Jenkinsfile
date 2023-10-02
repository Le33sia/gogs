
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
        stage('Deploy to Ubuntu_Server') {
            steps {
                echo 'hello'  
                
            
            }
        }
    }
}        

        


        
        
