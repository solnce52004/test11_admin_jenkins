pipeline {

    environment {
        registry = "solnce52004/test11_admin_jenkins"
        registryCredential = 'dockerhub'
        containerName = 'container'
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
             sh String.format(
                   '''docker stop %s || true && docker rm %s && docker rmi -f %s  || true''',
                   containerName,
                   containerName,
                   myapp.id
                )

                 script{
                     myapp.run(' -p 5555:4444 --name=' + containerName)
                 }
             }
        }
        stage('Docker push') {
            steps {
                script{
                  docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                       myapp.push()
                   }

                }
            }
        }
    }
}
