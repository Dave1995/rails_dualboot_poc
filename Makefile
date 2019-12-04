test:
	/bin/bash -l -c "rvm use --create 2.5.5@customer42 \
		&& bundle install \
		&& rake db:create \
		&& rake db:migrate \
		&& rake test"


.PHONY: test