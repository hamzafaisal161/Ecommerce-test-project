# frozen_string_literal: true

class CreateJoinTableCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|
      t.integer :total_price, null: false, default: 0
      t.integer :quantity, null: false, default: 0
      t.belongs_to :cart, null: false, default: 0
      t.belongs_to :product, null: false, default: 0
      t.timestamps
    end
  end
end
