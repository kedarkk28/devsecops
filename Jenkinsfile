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
        stage('Build Image') {
          steps {
            sh 'docker build --platform linux/amd64 -t "java-devsecops-demo:$BUILD_NUMBER" -t "java-devsecops-demo:latest" .'
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
