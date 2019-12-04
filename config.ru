# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
require ::File.expand_path('../lib/rack/health_check', __FILE__)

map '/health' do
  run Rack::HealthCheck.new
end

run Rails.application
