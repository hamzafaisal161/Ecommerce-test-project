# frozen_string_literal: true

class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :name, null: false, default: ''
      t.string :contact_no
      t.string :gender
      t.string :address
      t.boolean :new_user, null: false, default: 'false'
    end
  end
end
