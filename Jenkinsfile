pipeline {
  agent none
    stages {
        stage('Create docker image') {
            agent { label 'docker' }
            steps {
                echo "${env.NODE_NAME}"
                sh 'echo "<br>Build by Jenkins: $BUILD_ID<br>" >> index.html'
                sh 'date >> index.html'
                sh ' docker build . -t conti-aws:$BUILD_ID'
            }
        }
        stage('Runing container') {
            agent { label 'docker' }
            steps {
                echo "${env.NODE_NAME}"
                sh 'docker run --name andy-tst --rm -d -p 81:80 conti-aws:$BUILD_ID'
            }
        }
        stage('Example Test') {
            agent { label 'docker' }
            steps {
                echo "${env.NODE_NAME}"
                sh 'docker stop andy-tst'
                sh 'docker tag conti-aws:latest conti-aws:old'
                sh 'docker tag conti-aws:$BUILD_ID conti-aws:latest'
            }
        }
        stage('Rotate images') {
            agent { label 'docker' }
            steps {
                echo "${env.NODE_NAME}"
                sh 'docker stop andy-www'
                sh 'docker run --name andy-www --rm -d -p 80:80 conti-aws:latest'
                sh 'docker rmi conti-aws:old conti-aws:$BUILD_ID'
            }
        }
    }
}

