# frozen_string_literal: true

require 'test_helper'

class SimpleTest < ActiveSupport::TestCase
  def test_simple
    assert Rails.gem_version < Gem::Version.new('6')
  end
end
