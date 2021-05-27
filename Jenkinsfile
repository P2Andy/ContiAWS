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
//    triggers { pollSCM('* * * * *') }
    agent none
    stages {
	stage("Create docker image") {
	    agent { label 'docker' }
	    steps {
		echo " -------===== Start building images ====-------- "
            	sh "docker build . -t conti-aws:$BUILD_ID"
	    }
	    steps {
		echo " -------===== Runing  building images ====-------- "
            	sh "docker run --name andy-tst --rm -d -p 81:80 conti-aws:$BUILD_ID"
	    }
	    steps {
		echo " -------===== Stop  building images ====-------- "
            	sh "docker stop andy-tst"
		sh "docker tag conti-aws:latest conti-aws:old"
		sh "docker tag conti-aws:$BUILD_ID conti-aws:latest"
	    }
	    steps {
		echo " -------===== delete  building images ====-------- "
            	sh "docker stop andy-www"
            	sh "docker run --name andy-www --rm -d -p 80:80 conti-aws:latest"
            	sh "docker rmi conti-aws:old conti-aws:$BUILD_ID"
	    }
	}
    }
}
