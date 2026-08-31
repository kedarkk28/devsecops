pipeline {
    agent any
    tools {
        maven 'maven3'
    }
    environment {
        SONAR_IP = 'localhost'
    }
    stages {
         
        stage('Build') {
            steps {
                echo 'Code is already checked out and available!'
            }
        }
        stage('Trivy scan') {
            steps {
                sh 'trivy fs --exit-code 1 --severity HIGH,CRITICAL .'
            }
        }
        stage('Build & Sonar') {
            steps {
                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
              sh 'mvn clean verify sonar:sonar \
              -Dsonar.projectKey=devsecops-demo \
              -Dsonar.host.url="http://${SONAR_IP}:9000" \
              -Dsonar.token="${SONAR_TOKEN}" \
              -Dsonar.qualitygate.wait=true'
            }
            }
        }
/*
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
