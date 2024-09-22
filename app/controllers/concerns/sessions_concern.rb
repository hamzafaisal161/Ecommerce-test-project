# frozen_string_literal: true

module SessionsConcern
  extend ActiveSupport::Concern

  def load_user_cart(cart, user_cart)
    temp_cart_products = CartProduct.where(cart_id: cart.id)
    user_cart_products = CartProduct.where(cart_id: user_cart.id)
    temp_cart_products.each do |product|
      if user_cart_products.where(product_id: product.product_id).empty?
        product.update!(cart_id: user_cart.id)
      else
        update_user_cart_product(product)
      end
    end
    product_ids = Product.where(user_id: current_user.id).pluck(:id)
    cart_products = user_cart_products.where(product_id: product_ids)
    cart_products.destroy! notice: I18n.t(:own_product_cart) if @cart_products.present?
    cart.destroy!
  end

  def update_user_cart_product(product)
    unit_price = product.total_price / product.quantity
    user_cart_product = user_cart_products.find_by(product_id: product.product_id)
    total_quantity = user_cart_product.quantity + product.quantity
    total_price = unit_price * total_quantity
    user_cart_product.update!(total_price: total_price, quantity: total_quantity)
  end
end
