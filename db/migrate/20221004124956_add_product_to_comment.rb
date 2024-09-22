# frozen_string_literal: true

class AddProductToComment < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :product, index: true, on_delete: :cascade
  end
end
