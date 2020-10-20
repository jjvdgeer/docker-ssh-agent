pipeline {
    environment {
        registry = "jjvdgeer/jenkins-ssh-agent"
        dockerImage = ''
    }
    agent { label 'docker' }
    stages {
        stage('Clone sources') {
            steps {
                git url: 'https://github.com/jjvdgeer/jenkins-ssh-agent.git'
            }
        }
        stage('Building our image') {
            steps {
                script {
                    docker.withRegistry('http://qnap:5000/') {
                        dockerImage = docker.build registry + ":$BUILD_NUMBER"
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Tag as latest') {
            steps {
                script {
                    docker.withRegistry('http://qnap:5000/') {
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Cleaning up') {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}
