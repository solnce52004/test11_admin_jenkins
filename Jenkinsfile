pipeline {

    environment {
        registry = "solnce52004/test11_admin_jenkins"
        registryCredential = 'dockerhub'
    }

    agent any

    stages {
        stage('Build gradle') {
              steps {
                 sh './gradlew build'
              }
        }
        stage("Checkout code") {
              steps {
                 checkout scm
              }
        }
        stage ('Docker Build') {
          steps {
            script {

//               withDockerServer([uri: "tcp://localhost:2375/"]) {
                withDockerRegistry([credentialsId: registryCredential, url: "https://hub.docker.com/repository/docker/solnce52004/"]) {

                   docker.build(registry + ":${env.BUILD_ID}", ".").push("${env.BUILD_ID}")
                }
//               }
            }
          }
        }
//         stage('Docker build and push') {
//             steps {
//                 script{
//                   docker.build(registry + ":${env.BUILD_ID}", ".").push("${env.BUILD_ID}")
//                 }
//             }
//         }
        stage('Docker run') {
            steps {
                script{
                  docker.image(registry + ":${env.BUILD_ID}").withRun('-d --rm -p 5555:4444') { c -> sh 'echo "ok"'}
                }
            }
        }
    }
}
