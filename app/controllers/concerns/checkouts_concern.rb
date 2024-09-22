# frozen_string_literal: true

module CheckoutsConcern
  extend ActiveSupport::Concern
  require 'paypal-sdk-rest'
  include PayPal::SDK::REST

  def update_cart_products(cart_products, order)
    cart_products.each do |product|
      product.update!(order_id: order.id)
    end
  end

  def create_cart
    @cart.update!(user_id: nil)
    @cart = Cart.create!(user_id: current_user.id, total_price: 0)
    return unless current_user.new_user

    current_user.update_column(:new_user, false) # rubocop:disable Rails/SkipsModelValidations
  end

  def create_order(payment_id, payer_id)
    order = current_user.orders.create!(payment_id: payment_id, payer_id: payer_id)
    order.update!(total_amount: @cart.total_price, cart_id: @cart.id)
    create_cart
    order
  end

  def create_payment(cart, cart_products)
    Payment.new({
                  intent: I18n.t(:sale),
                  payer: {
                    payment_method: I18n.t(:paypal)
                  },
                  redirect_urls: {
                    return_url: complete_paypal_checkouts_url,
                    cancel_url: cart_url(cart)
                  },
                  transactions: [
                    {
                      amount: {
                        total: cart.total_price,
                        currency: I18n.t(:currency)
                      },
                      description: I18n.t(:description),
                      item_list: {
                        items: cart_products.map(&:to_paypal)
                      }
                    }
                  ]
                })
  end

  def check_cart
    return unless @cart.total_price.zero?

    redirect_to cart_path(@cart.id) and return
  end
end
