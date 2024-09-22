# frozen_string_literal: true

class AddJoinTableWishlistProduct < ActiveRecord::Migration[5.2]
  def change
    create_table :products_wishlists do |t|
      t.belongs_to :wishlist
      t.belongs_to :product
      t.timestamps
    end
  end
end
