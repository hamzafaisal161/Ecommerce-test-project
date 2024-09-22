# frozen_string_literal: true

class AddUserToCarts < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :user, foreign_key: true, on_delete: :cascade
  end
end
