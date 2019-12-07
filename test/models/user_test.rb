require 'test_helper'
class UserTest < ActiveSupport::TestCase
  def test_that_test_are_running_in_transactions_part_a
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    User.transaction(requires_new: true) do
      assert_equal(2, User.count)
      User.delete_all
      assert_equal(0, User.count)
    end
    ActiveRecord::Base.logger = nil
  end

  def test_that_test_are_running_in_transactions_part_b
    User.transaction do
      assert_equal(2, User.count)
      User.delete_all
      assert_equal(0, User.count)
    end
  end
end
