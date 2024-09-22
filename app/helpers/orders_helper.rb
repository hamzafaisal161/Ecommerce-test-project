# frozen_string_literal: true

module OrdersHelper
  def get_cart_products(order)
    CartProduct.where(cart_id: order.cart_id)
  end
end
