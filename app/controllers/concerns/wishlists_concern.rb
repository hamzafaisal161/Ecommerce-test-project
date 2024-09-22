# frozen_string_literal: true

module WishlistsConcern
  extend ActiveSupport::Concern

  def create_wishlist
    return unless current_user.wishlist.nil?

    wishlist = Wishlist.create!(user_id: current_user.id)
    wishlist.save!
  end

  def check_product(product_id, wishlist)
    product = wishlist.products.find_by(id: product_id)
    product.present?
  end

  def save_wishlist_product(wishlist_product)
    if wishlist_product.save!
      redirect_to user_wishlist_path(current_user.id), notice: I18n.t(:wishlist_added)
    else
      redirect_to user_wishlist_path(current_user.id), alert: I18n.t(:wishlist_not_added)
    end
  end

  def check_empty(wishlist)
    if wishlist.products.empty?
      wishlist.destroy!
      redirect_to products_path, notice: I18n.t(:wishlist_empty)
    else
      redirect_to user_wishlist_path(current_user.id), notice: I18n.t(:wishlist_removed)
    end
  end
end
