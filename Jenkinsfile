pipeline {

    environment {
        registry = "solnce52004/test11_admin_jenkins"
        registryCredential = 'dockerhub'
        containerName = 'container'
    }

    agent any

    stages {
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
        stage('Docker run') {
             steps {
                 sh 'docker stop ' + containerName + ' || true && docker rm ' + containerName + ' || true'

                 script{
                     myapp.run('--rm -p 5555:4444 --name=' + containerName)
                 }
             }
        }
        stage('Docker push') {
            steps {
                script{
                  docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                       myapp.push("${env.BUILD_ID}")
                   }

                }
            }
        }
    }
}
