# frozen_string_literal: true

class AddUserToWishlist < ActiveRecord::Migration[5.2]
  def change
    add_reference :wishlists, :user, foreign_key: true, on_delete: :cascade
  end
end
