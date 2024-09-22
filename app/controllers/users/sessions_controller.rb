# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    include SessionsConcern
    include ApplicationsConcern

    def create
      @cart = Cart.find_by!(temp_cart: session[:session_id])
      super
      @user_cart = Cart.find_by(user_id: current_user.id)
      if @user_cart.nil?
        @cart.update!(user_id: current_user.id)
      else
        @cart = load_user_cart(@cart, @user_cart)
      end
    end
  end
end
