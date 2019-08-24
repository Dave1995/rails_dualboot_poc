FROM ruby:2.3.8 AS basemri23
COPY Gemfile Gemfile
RUN bundle install
