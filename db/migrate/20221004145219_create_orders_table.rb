# frozen_string_literal: true

class CreateOrdersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :payment_id, null: false, default: ''
      t.string :payer_id, null: false, default: ''
      t.integer :total_amount, null: false, default: 0
      t.references :user, foreign_key: true, on_delete: :cascade
      t.references :cart, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
  end
end
