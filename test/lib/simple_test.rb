# frozen_string_literal: true

require_relative '../test_helper'

class SimpleTest < ActiveSupport::TestCase
  def test_assertion
    assert Rails.gem_version < Gem::Version.new('6')
  end

  def test_raise
    assert true
  end

  def test_trigger_deprecation_warning
    ActiveSupport::Deprecation.warn('manually triggerd deprecation warning')
  end

  def test_trigger_another_deprecation_warning
    assert true
    # ActiveSupport::Deprecation.warn('manually triggerd deprecation warning')
  end
end
