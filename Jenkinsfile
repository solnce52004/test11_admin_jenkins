pipeline {
    agent { dockerfile true }

    stages {
        stage("Checkout code") {
              steps {
                 checkout scm
              }
        }
        stage('Docker build and push') {
            steps {
                def customImage = docker.build("solnce52004/test11_admin_jenkins:${env.BUILD_ID}", ".")
                customImage.push("${env.BUILD_ID}")
            }
        }
        stage('Docker pull') {
            steps {
                 docker.pull("solnce52004/test11_admin_jenkins:${env.BUILD_ID}")
            }
        }
        stage('Docker run') {
            steps {
                 docker.image("solnce52004/test11_admin_jenkins:${env.BUILD_ID}").withRun('-d --rm -p 5555:4444') { c -> sh 'echo "ok"'}
            }
        }
    }
}
