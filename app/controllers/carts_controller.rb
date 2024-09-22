# frozen_string_literal: true

class CartsController < ApplicationController
  include ApplicationsConcern
  include CartsConcern
  include CartsHelper

  def show
    @cart = user_signed_in? ? @cart : Cart.find_by!(temp_cart: session[:session_id])
    @cart_products = CartProduct.where(cart_id: @cart.id)
    @final_sum = cart_sum(@cart_products)
    @cart.update!(total_price: @final_sum)
    @final_sum = discount(@cart, @cart_products) if user_signed_in?
  end

  def add_to_cart
    cart_product = CartProduct.find_by(cart_id: @cart.id, product_id: params[:product_id].to_i)
    if cart_product.nil?
      create_cart_product(params[:product_id].to_i, params[:quantity], @cart)
    else
      quantity = params[:quantity].to_i + cart_product.quantity
      total_price = update_total_price(cart_product, quantity)
      update_cart_product(total_price, quantity, cart_product)
    end
    redirect_to cart_path(@cart)
  end

  def update_cart
    cart_product = CartProduct.find_by!(product_id: params[:product_id], cart_id: params[:cart_id])
    cart_products = CartProduct.where(cart_id: @cart.id)
    final_sum = cart_sum(cart_products)
    cart_product.update!(quantity: params[:quantity], total_price: final_sum)
    redirect_to cart_path(@cart), notice: I18n.t(:cart_update_success)
  end

  def remove_from_cart
    cart_product = CartProduct.find(params[:cart_id])
    cart_product.destroy!
    cart_products = CartProduct.where(cart_id: @cart.id)
    final_sum = cart_sum(cart_products)
    @cart.update!(total_price: final_sum)
    redirect_to cart_path(@cart), notice: I18n.t(:cart_remove_success)
  end
end
