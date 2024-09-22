# frozen_string_literal: true

class CreateWishlists < ActiveRecord::Migration[5.2]
  def change
    create_table :wishlists, &:timestamps
  end
end
