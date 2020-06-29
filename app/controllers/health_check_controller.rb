class HealthCheckController < ApplicationController
  # GET /customers
  # GET /customers.json
  def get
    render json: { status: :healty, rails_version: Rails::VERSION::STRING}
  end
end