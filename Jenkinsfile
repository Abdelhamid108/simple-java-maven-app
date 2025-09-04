pipeline {
    // Define the Jenkins agent where this pipeline will run
    agent {
        label {
            label 'instance_gcp'   // Jenkins node/agent label
            retries 2              // Retry twice if the node is temporarily unavailable
        }
    }

    // Environment variables used throughout the pipeline
    environment {
        REPO_NAME = "abdelhameed208/test_maven" // Docker repository name
        TAG = "latest"                           // Docker image tag
    }

    // Define the tools needed for this pipeline
    tools {
        maven "M399" // Maven installation configured in Jenkins
    }

    stages {
        stage ("Build") {
            // Stage for building the project
            steps {
                // Run Maven clean and package to compile the project and create the artifact
                sh "mvn clean package"
            }
        }

        stage ("Test") {
            // Stage for running unit tests
            steps {
                // Run Maven tests
                sh "mvn test"
            }
            post {
                // Always collect test results regardless of success/failure
                always {
                    // Publish JUnit test reports to Jenkins
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }

        stage ("Build_image") {
            // Stage for building and pushing Docker image
            steps {
                script{
                    // Connect to Docker registry using Jenkins credentials (docker_hub)
                    docker.withRegistry('', 'docker_hub') {
                        // Build Docker image from Dockerfile in repo root
                        def myimage = docker.build "${env.REPO_NAME}:${env.TAG}"
                        // Push the image to the Docker registry
                        myimage.push()
                    }
                }
            }
        }
    }
}
