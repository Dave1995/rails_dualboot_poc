def runTestsWithGemfile(gemfile_name) {
  try{
    stage('prepare'){
      sh "mkdir -p ../workspace_${gemfile_name}"
      sh "cp -r ./* ../workspace_${gemfile_name}"
    }
    stage('setup DB'){
      dir("../workspace_${gemfile_name}"){
        sh "docker network create RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}_${gemfile_name}"
        sh "docker run --rm --network RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}_${gemfile_name} --name RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}_${gemfile_name} -e POSTGRES_PASSWORD=postgres -d postgres"
        sh 'sleep 10'
        sh "docker logs RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}_${gemfile_name}"
        sh "docker exec -u postgres RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}_${gemfile_name} psql postgres -c \"CREATE DATABASE customer_development with OWNER=postgres;\""
        sh "docker exec -u postgres RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}_${gemfile_name} psql postgres -c \"CREATE DATABASE customer_test with OWNER=postgres;\""
      }
    }
    stage('test'){
      dir("../workspace_${gemfile_name}"){
        try{
        sh """
      docker run -u 1000:1000 -i --network RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}_${gemfile_name} -v `pwd`:/workspace -w /workspace ruby:2.5.5 /bin/bash << EOR
      echo 'test'
      curl RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}_${gemfile_name}:5432
      cd /workspace
      ls -la
      export DB_HOST=RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}_${gemfile_name}
      export BUNDLE_GEMFILE=${gemfile_name}
  bundle install
  rake db:create
  rake db:migrate
  rake test
EOR
    """
        }catch(e){
          throw e
        }finally{
          junit "test/reports/*.xml"

        }
      }
    }
  }catch(e){
    throw e
  }finally{
    stage("rm workspace"){
      sh "rm -rf ../workspace_${gemfile_name}"
    }
    stage('teardown DB'){
      sh "docker container stop RAILS_DUALBOOT_POC_DB_${BUILD_NUMBER}_${gemfile_name}"
    }
  }
}

def buildProductionImageWithGemfileAndTag(gemfile_name, tag) {
  stage('build'){
    def app = docker.build("quay.io/doerler/rails_dualboot_poc:${tag}", " --build-arg GEMFILE=${gemfile_name} .")
    docker.withRegistry('https://quay.io', 'quay.io') {
      app.push("${tag}")
    }
  }
}

withCredentials([string(credentialsId: 'github-webhook-token', variable: 'githubWebhookToken')]) {
  properties([
    pipelineTriggers([GenericTrigger(causeString: 'Generic Cause', regexpFilterExpression: '', regexpFilterText: '', token: "rails_dualboot_poc-${githubWebhookToken}")])
  ])
}

node(){
  stage('checkout'){
    cleanWs()
    checkout scm
  }
  parallel rails4_2: {
    runTestsWithGemfile("Gemfile")
  }, rails_6_0: {
    runTestsWithGemfile("Gemfile60")
  }
  parallel rails4_2: {
    buildProductionImageWithGemfileAndTag("Gemfile","latest")
  }, rails_6_0: {
    buildProductionImageWithGemfileAndTag("Gemfile60","latest_rails60")
  }
  stage('deploy'){
    sh "docker stack deploy customer -c ./docker-compose.yml"
  }
}
