# frozen_string_literal: true

class OrdersController < ApplicationController
  include OrdersHelper

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
    @cart_products = CartProduct.where(cart_id: @order.cart_id)
  end
end
