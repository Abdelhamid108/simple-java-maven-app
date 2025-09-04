pipeline {
  agent {
  label {
    label 'instance_gcp'
    retries 2
    }
  }
  environment {
      REPO_NAME = "abdlehameed208/test_maven"
      TAG = "latest"
  }

  tools {
    maven "M399"
  }
  stages {
    stage ("Build") {
      steps {
        sh "mvn clean package"
      }
    }
    stage ("Test") {
      steps {
        sh "mvn test"
      }
      post {
        always {
          junit 'target/surefire-reports/*.xml'
        }
      }
    }
    stage ("Build_image") {
      steps {
        script{
          docker.withRegistry('', 'docker-hub'){
            def myimage = docker.build "${env.REPO_NAME}:${env.TAG}"
            myimage.push()
          }
        }
      }
    }
  }
}
