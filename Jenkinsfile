pipeline {

    agent {
      dockerfile {
        filename 'Dockerfile'
      }
    }

    stages {
        stage("Checkout code") {
              steps {
                 checkout scm
              }
        }
        stage('Docker build and push') {
            steps {
                script{
                  docker.build("solnce52004/test11_admin_jenkins:${env.BUILD_ID}", ".").push("latest").push("${env.BUILD_ID}")
                }
            }
        }
        stage('Docker run') {
            steps {
                script{
                  docker.image("solnce52004/test11_admin_jenkins:${env.BUILD_ID}").withRun('-d --rm -p 5555:4444') { c -> sh 'echo "ok"'}
                }
            }
        }
    }
}
