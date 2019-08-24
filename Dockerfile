FROM ruby:2.3.8 AS basemri23
# Build base image
FROM ruby:2.5.1 AS basemri25
# Build base image
FROM jruby:9.1.17 AS basejruby91

FROM jruby:9.2.5 AS basejruby92

FROM base23  AS app23
COPY Gemfile Gemfile

FROM base25 AS app25
COPY Gemfile_next Gemfile
