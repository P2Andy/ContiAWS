environment {
  IMAGE_BASE = 'project-conti'
  IMAGE_TAG = "v$BUILD_NUMBER"
  IMAGE_NAME = "${env.IMAGE_BASE}:${env.IMAGE_TAG}"
  IMAGE_NAME_LATEST = "${env.IMAGE_BASE}:latest"
}

def DOCKER_IMAGE_BRANCH = "v$BUILD_NUMBER"
def DOCKER_INT_TEST = "andy-www"
def GIT_COMMIT_HASH = ""

pipeline { 
    options {
        buildDiscarder(
            logRotator(
                artifactDaysToKeepStr: "",
                artifactNumToKeepStr: "",
                daysToKeepStr: "",
                numToKeepStr: "10"
            )
        )
        disableConcurrentBuilds()
    }
    triggers { pollSCM('* * * * *') }
    agent any

    stages {
	stage("Create docker image") {
	    steps {
		echo " -------===== Start building images ====-------- "
            	sh "docker build . -t project-build:${DOCKER_IMAGE_BRANCH}"
	    }
	}
	stage("Runing docker image") {
	    steps {
		echo " -------===== Runing  building images ====-------- "
            	sh "docker run --name andy-tst --rm -d -p 82:80 project-build:${DOCKER_IMAGE_BRANCH}"
	    }
	}
	stage("Stoping docker image") {
	    steps {
		echo " -------===== Stop  building images ====-------- "
            	sh "docker stop andy-tst"
		sh "docker tag project-build:last project-build:old"
		sh "docker tag project-build:${DOCKER_IMAGE_BRANCH} project-build:last"
	    }
	}
	stage("Delete docker image") {
	    steps {
		echo " -------===== delete  building images ====-------- "
            	sh "docker stop andy-www"
            	sh "docker rmi project-build:old"
            	sh "docker run --name andy-www --rm -d -p 81:80 project-build:last"
	    }
	}
    }
}
