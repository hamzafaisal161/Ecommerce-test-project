# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    include ApplicationsConcern

    def create
      @cart = Cart.find_by!(temp_cart: session[:session_id])
      super
      return if current_user.nil?

      flash[:notice] = I18n.t(:cart_update_fail) unless @cart.update!(user_id: current_user.id)
      sign_out current_user
      new_user_session_path
    end
  end
end
