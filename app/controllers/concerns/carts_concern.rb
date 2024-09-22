# frozen_string_literal: true

module CartsConcern
  extend ActiveSupport::Concern

  def get_product(id)
    Product.find(id)
  end

  def update_total_price(cart_product, quantity)
    (cart_product.total_price / cart_product.quantity) * quantity.to_i
  end

  def cart_sum(cart_products)
    cart_products.collect { |cart_product| cart_product.valid? ? cart_product.total_price : 0 }.sum
  end

  def discount(cart, cart_products)
    final_price = cart.total_price
    if current_user.new_user
      cart_products.each do |product|
        product.total_price *= 0.95
        product.total_price = product.total_price.to_i
      end
      final_price = cart_sum(cart_products).to_i
      cart.update!(total_price: final_price)
    end
    final_price
  end

  def create_cart_product(product_id, quantity, cart)
    product = Product.find(product_id)
    total_price = quantity.to_i * product.price
    cart_product = CartProduct.create!(cart_id: cart.id, product_id: product_id, quantity: quantity,
                                       total_price: total_price)
    flash[:notice] = if cart_product.save!
                       I18n.t(:product_added_cart)
                     else
                       I18n.t(:product_not_added_cart)
                     end
  end

  def update_cart_product(total_price, quantity, cart_product)
    cart_product.update!(quantity: quantity, total_price: total_price)
    flash[:notice] = if cart_product.save!
                       I18n.t(:product_updated_cart)
                     else
                       I18n.t(:product_not_updated_cart)
                     end
  end
end
