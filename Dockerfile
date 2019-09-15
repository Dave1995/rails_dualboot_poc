FROM ruby:2.3.8 AS rails42
COPY Gemfile Gemfile
RUN bundle install
WORKDIR /workspace
COPY ./ ./
RUN ls -la
ENTRYPOINT /bin/bash -c "SECRET_KEY_BASE=`rake secret` rails s -b 0.0.0.0"


FROM ruby:2.5.5 AS rails50
ENV BUNDLE_GEMFILE=Gemfile50
COPY Gemfile50 Gemfile50
RUN bundle install
WORKDIR /workspace
COPY ./ ./
RUN ls -la
ENTRYPOINT /bin/bash -c "SECRET_KEY_BASE=`rake secret` rails s -b 0.0.0.0"