# frozen_string_literal: true

# Your Ruby Rack App that returns your Rails App's Health
# Create the file
# "lib/rack/health_check.rb"

module Rack
  class HealthCheck
    def call(_env)
      status = {
        # postgres: {
        #   connected: postgres_connected,
        #   migrations_updated: postgres_migrations_updated,
        #   rails_version: Rails.version
        # },
        version: {
          rails: Rails.version
        }
      }

      [200, {}, [status.to_json]]
    end

    protected

    def postgres_connected
      ApplicationRecord.establish_connection
      ApplicationRecord.connection
      ApplicationRecord.connected?
    rescue StandardError => e
      false
    end

    def postgres_migrations_updated
      return false unless postgres_connected

      !ApplicationRecord.connection.migration_context.needs_migration?
    end
  end
end
