# frozen_string_literal: true

module ApplicationsConcern
  extend ActiveSupport::Concern

  def initialize_session_cart
    if Cart.find_by(temp_cart: session[:session_id]).nil?
      @cart = Cart.create!(temp_cart: session[:session_id], total_price: 0, quantity: 0)
      @cart.save!
      session[:cart_id] = @cart.id
    else
      @cart = Cart.find_by!(temp_cart: session[:session_id])
    end
  end

  def load_cart
    @cart = if user_signed_in?
              Cart.find_by!(user_id: current_user.id)
            else
              Cart.find_by!(temp_cart: session[:session_id])
            end
  end
end
