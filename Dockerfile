ARG RUBY_VERSION=2.5.5
ARG GEMFILE=Gemfile
FROM ruby:${RUBY_VERSION}
ENV BUNDLE_GEMFILE=${GEMFILE}
WORKDIR /workspace
COPY Gemfile* ./
# COPY *.lock ./
RUN ls -la
RUN bundle install
COPY ./ ./
ENTRYPOINT /bin/bash -c "SECRET_KEY_BASE=`rake secret` rails s -b 0.0.0.0"