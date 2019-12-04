# frozen_string_literal: true

class CreateCustomers < Schaltroom.active_before?(Rails, '5.0') ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    create_table :customers do |t|
      t.timestamps null: false
    end
  end
end
