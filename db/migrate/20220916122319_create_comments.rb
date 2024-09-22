# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :description, null: false, default: ''
      t.references :user, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
  end
end
