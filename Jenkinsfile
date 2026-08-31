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
            sh 'docker build -t "java-devsecops-demo:$BUILD_NUMBER" -t "java-devsecops-demo:latest" .'
          }
        }
        stage('Trivy Image Scan') {
            steps {
               sh 'trivy image --exit-code 1 --severity HIGH,CRITICAL "java-devsecops-demo:$BUILD_NUMBER"' 
            }
        }
        stage('Load image to kind cluster') {
          steps {
            sh 'kind load docker-image "java-devsecops-demo:$BUILD_NUMBER" --name k8s-multi-node-cluster'
            sh 'kind load docker-image "java-devsecops-demo:latest" --name k8s-multi-node-cluster'
          }
        }
        stage('Update Deployment') {
            steps {
                sh 'sed -i "s|image:.*|image: java-devsecops-demo:$BUILD_NUMBER|g" deploy.yaml'
            }
        }
        
        stage('Deploy to Kubernetes') {
    steps {
        sh '''#!/bin/bash -l
kubectl delete ns java-devsecops
kubectl create ns java-devsecops
kubectl apply -f deploy.yaml
kubectl apply -f svc.yaml

'''    
    }
}
    }
}
/*
        stage() {
            steps {
                
            }
        }
*/
