# frozen_string_literal: true

class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def to_paypal
    product = Product.find(product_id)
    cart = Cart.find(cart_id)
    user = User.find(cart.user_id)
    price = product.price
    price *= 0.95 if user.new_user?
    price = price.to_i
    {
      name: product.name,
      sku: product.serial_no,
      price: price,
      currency: 'USD',
      quantity: quantity
    }
  end
end
