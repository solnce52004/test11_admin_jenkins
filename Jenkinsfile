pipeline {

    environment {
        registry = "solnce52004/test11_admin_jenkins"
        registryCredential = 'dockerhub'
        containerName = 'container'
    }

    agent any

    stages {
       agent { docker{ image "openjdk:11.0.13-jdk-slim" }}
        stage('ssl') {
             steps {
                    sh "keytool -importcert -file ./tomcat-private.crt -alias localtomcat -cacerts -keystore /usr/lib/jvm/java-11-openjdk-amd64/lib/security/cacerts -keypass Zerkalo82 -storepass changeit"
                }
        }
        stage('Build') {
             steps {
                    sh "./gradlew build"
                }
        }
        stage('Docker rmi') {
            steps {
                 sh String.format(
                     '''
                        docker stop %s \
                       || true && docker rm %s && docker rmi -f $(docker images | grep %s | awk '{print $3}') \
                        || true
                     ''',
                     containerName,
                     containerName,
                     registry
                 )
            }
        }
        stage('docker network') {
             steps {
                 sh "docker network create -d bridge test11 || true"
             }
        }
        stage('Docker build') {
             steps {
                  script{
                       myApp =  docker.build(registry + ":${env.BUILD_ID}", ".")
                  }
             }
        }
        stage('Docker run') {
            steps {
                script{
                   myApp.run(' -d -p 5555:4444 --network="test11" --name=' + containerName)
                }
            }
        }
        stage('Docker push') {
            steps {
                script{
                  docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                       myApp.push("${env.BUILD_ID}")
                   }
                }
            }
        }
    }
}
