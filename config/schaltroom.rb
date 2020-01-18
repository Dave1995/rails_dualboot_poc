# frozen_string_literal: true

require 'schaltroom'

Schaltroom.config do |config|
  config.monitoring = :enabled
  config.monitoring_file = nil
end

Schaltroom.repository do |repository|
  repository.add_feature(:deprecated_finders, :boolean, true)
  repository.add_feature(:find_backport, :boolean, true)
  repository.add_feature(:rails, :version, Rails::VERSION::STRING)
end