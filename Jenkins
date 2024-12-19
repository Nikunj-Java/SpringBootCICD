pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "springboot-docker"
        GITHUB_REPO = "https://github.com/Nikunj-Java/SpringBootCICD.git"
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo "Cloning Repository"
                git branch: 'main', url: "${GITHUB_REPO}"
            }
        }

        stage('Compilation') {
            steps {
                echo "Creating .jarFile"
                script {
                    sh "mvn clean install -DskipTests"
                }
            }
        }
        stage('Build Docker Images') {
            steps {
                echo "Building Docker Image"
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "Running Docker Image in a Container"
                script {
                    sh """
                        docker stop springboot-container || true
                        docker rm springboot-container || true
                        docker run -d --name springboot-container -p 8082:8082 ${DOCKER_IMAGE}
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline Executed Successfully"
        }
    }
}
