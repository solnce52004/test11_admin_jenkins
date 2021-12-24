pipeline {

    environment {
        registry = "solnce52004/test11_admin_jenkins"
        registryCredential = 'dockerhub'
    }
    agent {
      dockerfile {
        filename 'Dockerfile'
      }
    }

    stages {
        stage('Build gradle') {
              script {
                    sh "./gradlew build"
              }
        }
        stage("Checkout code") {
              steps {
                 checkout scm
              }
        }
        stage('Docker build and push') {
            steps {
                script{
                  docker.build(registry + ":${env.BUILD_ID}", ".").push("latest").push("${env.BUILD_ID}")
                }
            }
        }
        stage('Docker run') {
            steps {
                script{
                  docker.image(registry + ":${env.BUILD_ID}").withRun('-d --rm -p 5555:4444') { c -> sh 'echo "ok"'}
                }
            }
        }
    }
}
