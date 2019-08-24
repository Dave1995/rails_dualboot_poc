withCredentials([string(credentialsId: 'github-webhook-token', variable: 'githubWebhookToken')]) {
  properties([
    pipelineTriggers([GenericTrigger(causeString: 'Generic Cause', regexpFilterExpression: '', regexpFilterText: '', token: "rails_dualboot_poc-${githubWebhookToken}")])
  ])
}

node(){
  stage('checkout'){
    checkout scm
  }
  stage('build'){
    def app = docker.build("quay.io/doerler/rails_dualboot_poc:latest")
    docker.withRegistry('http://quay.io', 'quay.io') {
      app.push
    }
  }
}
