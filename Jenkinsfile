pipeline {
    agent any
    tools {
        maven 'maven3'
    }
    stages {
         
        stage('Build') {
            steps {
                echo 'Code is already checked out and available!'
            }
        }
        /*stage('Trivy scan') {
            steps {
                sh 'trivy fs --exit-code 1 --severity HIGH,CRITICAL .'
            }
        }
        stage() {
            steps {
                
            }
        }
        stage() {
            steps {
                
            }
        }*/
    }
}
