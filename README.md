Rails 4.2 and 5.2 dualboot POC with mri and jruby support.

# Bundle Update
```bash
# run Bundle update on all Gemfiles
bundle update
BUNDLE_GEMFILE=Gemfile50 bundle update
BUNDLE_GEMFILE=Gemfile51 bundle update
BUNDLE_GEMFILE=Gemfile52 bundle update
BUNDLE_GEMFILE=Gemfile60 bundle update


Creation:
docker run -u `id -u`:`id -g` -v `pwd`:/rails_dualboot_poc -it ruby:2.3.8 /bin/bash -c "cd /rails_dualboot_poc && gem install rails -v 4.2.11 && rails new ./ --database=postgresql --skip-spring --skip-sprockets --skip-javascript --skip-turbolinks --api && rails generate scaffold customer" 

PostgreSQL Setup
```bash
docker pull postgres
mkdir -p $HOME/docker/volumes/postgres
docker network create pg-docker
docker run --rm --network pg-docker --name pg-docker -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data  postgres
docker exec -it -u postgres pg-docker psql postgres -c "create role postgres with createdb login password 'postgres';"
docker exec -it -u postgres pg-docker psql postgres -c "create role rails_dualboot_poc_test with createdb login password 'rails_dualboot_poc_test';"
docker exec -it -u postgres pg-docker psql postgres -c "create role dualboot_prod with createdb login password 'dualboot_prod';"

docker exec -it -u postgres pg-docker psql postgres -c "CREATE DATABASE customer_development with OWNER=postgres;"
docker exec -it -u postgres pg-docker psql postgres -c "CREATE DATABASE customer_test with OWNER=postgres;"
docker exec -it -u postgres pg-docker psql postgres -c "CREATE DATABASE customer with OWNER=postgres;"
```

ruby 2.3.8
```bash
bundle install
rake db:setup
rake db:migrate
rake test
```

JRuby 9.1.17.0
```bash
bundle _1.17.3_ install
rake db:setup
rake db:migrate
rake test
```

trigger webhook
