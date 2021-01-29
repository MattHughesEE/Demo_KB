pipeline {

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git url:'https://github.com/MattHughesEE/Demo_KB.git', branch:'default'
      }
    }
    
      stage("Build image") {
            steps {
                script {
                    myapp = docker.build("mrh1127/my-private-repo:v1")
                }
            }
        }
    
      stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                            myapp.push("latest")
                            myapp.push("v1")
                    }
                }
            }
        }

    
    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "manifest.yaml", kubeconfigId: "mykubeconfig")
        }
      }
    }

  }

}
