pipeline {
  // Run on an agent where we want to use Go
  agent any

  // Ensure the desired Go version is installed for all stages,
  // using the name defined in the Global Tool Configuration
  tools { go '1.20.6' }

  stages {
    stage('Build') {
      steps {
        // Output will be something like "go version go1.20.6"
        sh 'go version'
        //build the application
        sh "go build -o gogs"
      }
    }
    
    stage('Test') {
      steps {
        //Run tests  
        sh 'go vet ./...'
                
                   echo 'Running test'
                  // sh 'go test ./...'
      }
    }
  }
} 
