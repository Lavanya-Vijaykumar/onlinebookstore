pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "lavanyavijay12/online-bookstore"
        DOCKER_TAG = "${BUILD_NUMBER}"
        EC2_IP = "3.110.63.229"
    }

    tools {
        maven 'Maven'
    }

    stages {

        stage('Build Project') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh '''
                        echo $PASS | docker login -u $USER --password-stdin
                    '''
                }
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ec2-user@$EC2_IP '
                        docker pull $DOCKER_IMAGE:$DOCKER_TAG &&
                        docker stop bookstore || true &&
                        docker rm bookstore || true &&
                        docker run -d -p 8080:8080 --name bookstore $DOCKER_IMAGE:$DOCKER_TAG
                        '
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Online Bookstore Deployed Successfully 🚀"
        }
        failure {
            echo "Pipeline Failed ❌"
        }
    }
}
