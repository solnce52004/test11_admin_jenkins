pipeline {

    environment {
        registry = "solnce52004/test11_admin_jenkins"
        registryCredential = 'dockerhub'
    }

    agent any

    stages {
//         stage('Build gradle') {
//               steps {
//                  sh './gradlew build'
//               }
//         }
        stage("Checkout code") {
              steps {
                 checkout scm
              }
        }
        stage('Docker build') {
            steps {
                script{
                  myapp = docker.build(registry + ":${env.BUILD_ID}", ".")
                }
            }
        }
        stage('Docker push') {
            steps {
                script{
                  docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                       myapp.push("${env.BUILD_ID}")
                   }

                }
            }
        }
        stage('Docker run') {
            steps {
                sh 'docker stop container || true && docker rm container || true'

                script{
                  docker.image(registry + ":${env.BUILD_ID}").run('--rm -p 5555:4444 --name=container')
                }
            }
        }
    }
}
