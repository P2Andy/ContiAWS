pipeline {
  agent none
  environment {
      REPO_USR = 'p2andy'
      IMG_NAME = 'conti-aws'
      REPO_IMG = "${REPO_USR}/${IMG_NAME}"
  }
    stages {
        stage('Create docker image') {
            agent { label 'docker' }
            steps {
                echo "${env.NODE_NAME}"
                sh 'echo "<br>Build by Jenkins: $BUILD_ID<br>" >> index.html'
                sh 'date >> index.html'
                sh ' docker build . -t $IMG_NAME:$BUILD_ID'
            }
        }
        stage('Runing new container') {
            agent { label 'docker' }
            steps {
                echo "${env.NODE_NAME}"
                sh 'docker run --name andy-tst --rm -d -p 81:80 $IMG_NAME:$BUILD_ID'
            }
        }
        stage('Example Test') {
            agent { label 'docker' }
            steps {
                echo "${env.NODE_NAME}"
                sh 'docker stop andy-tst'
                sh "docker tag $REPO_IMG:latest $IMG_NAME:old"
                sh "docker tag $IMG_NAME:$BUILD_ID $REPO_IMG:latest"
            }
        }
        stage('Rotate images') {
            agent { label 'docker' }
            steps {
                echo "${env.NODE_NAME}"
                sh "docker push $REPO_IMG:latest"
                sh 'docker stop andy-www'
                sh "docker run --name andy-www --rm -d -p 80:80 $REPO_IMG:latest"
                sh 'docker rmi $IMG_NAME:old $IMG_NAME:$BUILD_ID'
            }
        }
    }
}

