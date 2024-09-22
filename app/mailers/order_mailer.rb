# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default from: 'hamza.faisal@devsinc.com'

  def order_email
    @order = params[:order]
    user = User.find(@order.user_id)
    @cart_products = CartProduct.where(cart_id: @order.cart_id)
    mail(to: user.email, subject: 'Your order summary.')
  end
end
