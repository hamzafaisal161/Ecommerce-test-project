# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false, default: ''
      t.string :serial_no, null: false, default: ''
      t.integer :price, null: false, default: ''
      t.string :description, null: false, default: ''
      t.references :user, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
  end
end
