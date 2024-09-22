# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'hamza.faisal@devsinc.com'

  def price_update_email
    @product = params[:product]
    user_ids = @product.wishlists.pluck(:user_id)
    users = User.where(id: user_ids)
    users.each do |user|
      mail(to: user.email, subject: 'The price of a product in your wishlist has been updated.')
    end
  end
end
