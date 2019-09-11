FROM ruby:2.3.8 AS basemri23
COPY Gemfile Gemfile
RUN bundle install
WORKDIR /workspace
COPY ./ ./
RUN ls -la
ENTRYPOINT rails s

# FROM ruby:2.5.5 AS basemri25
# ENV BUNDLE_GEMFILE=Gemfile50
# COPY Gemfile50 Gemfile50
# RUN bundle install
# ENTRYPOINT rails s