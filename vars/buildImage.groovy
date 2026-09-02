def call() {
    sh 'docker build -t "java-devsecops-demo:$BUILD_NUMBER" -t "java-devsecops-demo:latest" .'
}
