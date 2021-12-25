pipeline {

    environment {
        registry = "solnce52004/test11_admin_jenkins"
        registryCredential = 'dockerhub'
        containerName = 'container'
        prevTage = (Number("${env.BUILD_ID}") - 1)
    }

    agent any

    stages {
        stage('Build') {
             steps {
                    sh "./gradlew build"
                }
        }
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
                sh new StringBuffer()
                    .append('docker stop ').append(containerName)
                    .append(' || true && docker rm ').append(containerName)
                    .append(' && docker rmi ').append(registry).append(":").append(prevTage)
                    .append(' || true')
                    .toString()

                 script{
                     myapp.run(' -p 5555:4444 --name=' + containerName)
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
