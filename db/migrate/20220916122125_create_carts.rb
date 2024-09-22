# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.integer :total_price, null: false, default: 0
      t.integer :quantity, null: false, default: 0
      t.string :temp_cart
      t.timestamps
    end
  end
end
