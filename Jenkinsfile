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
        stage('Docker push') {
            steps {
                script{
                  docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                    myApp =  docker.build(registry + ":${env.BUILD_ID}", ".")

                    sh "echo '*********'"
                    sh 'echo ' + myApp.id
                    sh String.format(
                         '''docker stop %s || true && docker rm %s && docker rmi -f %s  || true''',
                         containerName,
                         containerName,
                         myApp.id
                    )

                       myApp.run(' -p 5555:4444 --name=' + containerName)
                       myApp.push("${env.BUILD_ID}")
                   }
                }
            }
        }
    }
}
