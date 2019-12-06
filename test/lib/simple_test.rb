# frozen_string_literal: true

require 'test_helper'

class SimpleTest < ActiveSupport::TestCase
  def test_assertion
    assert Rails.gem_version < Gem::Version.new('6')
  end

  def test_raise
    assert true
  end
end
