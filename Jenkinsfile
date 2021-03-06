pipeline {
     agent any
     stages {
         stage('Build') {
              steps {
                  sh 'echo Building...'
              }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
         stage('Build Docker Image') {
              steps {
                  sh 'docker build -t capstone-project-cloud-devops .'
              }
         }
         stage('Push Docker Image') {
              steps {
                  withDockerRegistry([url: "", credentialsId: "dockerHub"]) {
                      sh "docker tag capstone-project-cloud-devops rchintakula/capstone-project-cloud-devops"
                      sh 'docker push rchintakula/capstone-project-cloud-devops'
                  }
              }
         }
         stage('Deploying') {
              steps{
                      sh "aws eks --region eu-west-2 update-kubeconfig --name cluster"
                      sh "kubectl config use-context arn:aws:eks:eu-west-2:042518807383:cluster/cluster"
                      sh "kubectl set image deployments/capstone-project-cloud-devops capstone-project-cloud-devops=rchintakula/capstone-project-cloud-devops:latest"
                      sh "kubectl apply -f deployment/deployment.yml"
                      sh "kubectl get nodes"
                      sh "kubectl get deployment"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/capstone-project-cloud-devops"
                      sh "kubectl get pods"
                      sh "kubectl rollout status deployment capstone-project-cloud-devops"

              }
        }
        stage("Cleaning up") {
              steps{
                    echo 'Cleaning up...'
                    sh "docker system prune"
              }
        }
     }
}
