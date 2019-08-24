withCredentials([string(credentialsId: 'github-webhook-token', variable: 'githubWebhookToken')]) {
  properties([
    pipelineTriggers([GenericTrigger(causeString: 'Generic Cause', regexpFilterExpression: '', regexpFilterText: '', token: "rails_dualboot_poc-${githubWebhookToken}")])
  ])
}

node(){
  stage('checkout'){
    scm checkout
  }
  stage('build'){
    sh 'docker build .'
  }
}
