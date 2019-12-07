# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

require 'minitest/reporters'
class Minitest::Reporters::BaseReporter
  def passed?
    return tests.none?(&:failure) if Rails.gem_version < Gem::Version.new('6')

    passed_with_whitelist_feature?
  end

  private

  def passed_with_whitelist_feature?
    failed_test_identifier_strings = []

    failed_tests = tests.select(&:failure)
    failed_tests.each do |t|
      test_identifier_string = "#{t.klass}##{t.name}"
      failed_test_identifier_strings << test_identifier_string
    end
    test_whitelist = YAML.load_file(File.join(__dir__, 'whitelist.yml'))
    failed_tests = failed_test_identifier_strings.reject { |t| test_whitelist.include?(t) }
    unless failed_tests.empty?
      puts 'The following failed tests are not part of the whitelist:'
      failed_tests.each { |test| puts "- #{test}" }
      return false
    end
    passed_tests = tests.select(&:passed?)
    passed_whitelisted_tests = test_whitelist.select { |t| passed_tests.include?(t) }
    unless passed_whitelisted_tests.empty?
      puts 'The following passing tests are on the whitelist. Please cleanup the whitelist'
      passed_whitelisted_tests.each { |test| puts "- #{test}" }
    end

    true
  end
end
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new,
                          Minitest::Reporters::JUnitReporter.new]
