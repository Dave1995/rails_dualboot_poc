# frozen_string_literal: true

class CreateCustomers < true ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    create_table :customers do |t|
      t.timestamps null: false
    end
  end
end
