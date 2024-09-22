# frozen_string_literal: true

module Paypal
  class CheckoutsController < ApplicationController
    require 'paypal-sdk-rest'
    include PayPal::SDK::REST
    include CheckoutsConcern

    def create
      check_cart
      unless user_signed_in?
        redirect_to new_user_session_path, alert: I18n.t(:must_signed_in)
        return
      end
      cart_products = CartProduct.where(cart_id: @cart.id)
      payment = create_payment(@cart, cart_products)
      if payment.create == true
        redirect_url = payment.links.find { |v| v.rel == I18n.t(:approval_url) }.href

        redirect_to redirect_url
      else
        redirect_to cart_path(@cart), alert: I18n.t(:went_wrong)
      end
    end

    def complete
      payment = Payment.find(params[:paymentId])
      if payment.execute(payer_id: params[:PayerID])
        order = create_order(params[:paymentId], params[:PayerID])
        OrderMailer.with(order: order).order_email.deliver_now
        redirect_to user_orders_path(current_user.id), notice: I18n.t(:purchase_thanks)
      else
        redirect_to cart_path(@cart), notice: I18n.t(:purchase_failed)
      end
    end
  end
end
