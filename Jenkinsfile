pipeline {
  agent {
  label {
    label 'instance_gcp'
    retries 2
  }
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
    stage ("Deliver") {
      steps {
        sh './jenkins/scripts/deliver.sh'
      }
    }
  }
}
