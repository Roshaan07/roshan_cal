pipeline {
    agent any
    environment{
        VERSION = "${env.BUILD_ID}"
    }
    stages {
        stage('clone') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Roshaan07/roshan_cal.git']]])
            }
        }
        stage('building docker image') {
            steps {
                sh '''
                docker build -t roshan07/webappcal:${VERSION} .
                docker tag roshan07/webappcal:${VERSION} roshan07/webappcal:latest
                docker login -u roshan07 -p reshmaa9642
                docker push roshan07/webappcal:${VERSION}
                docker push roshan07/webappcal:latest
                docker image rm roshan07/webappcal:${VERSION}
                '''
                
            }
        }
        stage('creating deployment on k8s cluster') {
            steps {
                sh '''
                kubectl apply -f webappcal.yml
                kubectl apply -f webappcalsvc.yml
                '''
            }
        }
        
    }
}
