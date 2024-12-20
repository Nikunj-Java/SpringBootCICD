pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "springboot-docker"
        GITHUB_REPO = "https://github.com/Nikunj-Java/SpringBootCICD.git"
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo "Cloning Repository from ${GITHUB_REPO}"
                git branch: 'main', url: "${GITHUB_REPO}"
            }
        }

        stage('Compilation') {
            steps {
                echo "Compiling and Building .jar File"
                timeout(time: 10, unit: 'MINUTES') { // Set timeout to avoid indefinite hangs
                    script {
                        // Adding debug logs for Maven
                        sh "mvn clean install -DskipTests -X"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker Image ${DOCKER_IMAGE}"
                script {
                    // Ensure Dockerfile exists at root and builds correctly
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "Running Docker Container from Image ${DOCKER_IMAGE}"
                script {
                    sh """
                        # Stop and remove existing container if exists
                        docker stop springboot-container || true
                        docker rm springboot-container || true
                        
                        # Run the Docker container
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
        success {
            echo "Pipeline Completed Successfully without Errors"
        }
        failure {
            echo "Pipeline Failed. Check logs for errors."
        }
    }
}
