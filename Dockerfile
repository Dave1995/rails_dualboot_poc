ARG RUBY_VERSION=2.5.5
ARG GEMFILE=Gemfile
FROM ruby:${RUBY_VERSION}
ENV BUNDLE_GEMFILE=${GEMFILE}
COPY ${GEMFILE} ${GEMFILE}
COPY ${GEMFILE}.lock ${GEMFILE}.lock
RUN bundle install
WORKDIR /workspace
COPY ./ ./
ENTRYPOINT /bin/bash -c "SECRET_KEY_BASE=`rake secret` rails s -b 0.0.0.0"