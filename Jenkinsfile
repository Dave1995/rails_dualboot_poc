withCredentials([string(credentialsId: 'github-webhook-token', variable: 'githubWebhookToken')]) {
  properties([
    pipelineTriggers([GenericTrigger(causeString: 'Generic Cause', regexpFilterExpression: '', regexpFilterText: '', token: "rails_dualboot_poc-${githubWebhookToken}")])
  ])
}

node(){
  stage('checkout'){
    checkout scm
  }
  try{
    stage('setup DB'){
      sh "docker network create RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}"
      sh "docker run --rm --network RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER} --name RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER} -e POSTGRES_PASSWORD=postgres -d postgres"
      sh "docker exec RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER} -u postgres psql postgres -c \"CREATE DATABASE customer_development with OWNER=postgres;\""
      sh "docker exec RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER} -u postgres psql postgres -c \"CREATE DATABASE customer_development with OWNER=postgres;\""
    }

  }catch(e){

  }finally{
    stage('teardown DB'){
      sh "docker container stop RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}"
      sh "docker container rm RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}"
    }
  }
  stage('build'){
    def app = docker.build("quay.io/doerler/rails_dualboot_poc:latest", "--target basemri23 .")
    docker.withRegistry('https://quay.io', 'quay.io') {
      app.push('latest')
    }
  }
}
