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
    def app = docker.image("quay.io/doerler/rails_dualboot_poc:latest")
    docker.withRegistry('https://quay.io', 'quay.io') {
      app.push('latest')
    }
  }
}
