ARG RUBY_VERSION=2.5.5
FROM ruby:${RUBY_VERSION}
ARG GEMFILE=Gemfile
ARG RUBY_VERSION
RUN echo ${GEMFILE}
ENV BUNDLE_GEMFILE=${GEMFILE}
WORKDIR /workspace
COPY Gemfile* ./
# COPY *.lock ./
RUN ls -la
RUN bundle install
COPY ./ ./
ENTRYPOINT /bin/bash -c "SECRET_KEY_BASE=`rake secret` rails s -b 0.0.0.0"