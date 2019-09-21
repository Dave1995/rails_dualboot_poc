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
      sh 'sleep 10'
      sh "docker logs RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}"
      sh "docker exec -u postgres RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER} psql postgres -c \"CREATE DATABASE customer_development with OWNER=postgres;\""
      sh "docker exec -u postgres RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER} psql postgres -c \"CREATE DATABASE customer_test with OWNER=postgres;\""
    }
    stage('test'){
      sh 'ls -la'
    sh """
      docker run -i --network RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER} -v `pwd`:/workspace -w /workspace ruby:2.5.5 /bin/bash << EOR
      echo 'test'
      curl RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}:5432
      cd /workspace
      ls -la
  bundle install
  rake db:create
  rake db:migrate
  rake test
EOR
    """
      sh 'ls -la'
      junit './test/reports/*.xml'
    }
  }catch(e){
    throw e
  }finally{
    stage('teardown DB'){
      sh "docker container stop RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}"
    }
  }
  stage('build'){
    def app = docker.build("quay.io/doerler/rails_dualboot_poc:latest", ".")
    docker.withRegistry('https://quay.io', 'quay.io') {
      app.push('latest')
    }
  }
}
