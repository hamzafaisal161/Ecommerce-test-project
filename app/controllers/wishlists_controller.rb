# frozen_string_literal: true

class WishlistsController < ApplicationController
  include WishlistsConcern

  def add_product
    create_wishlist
    wishlist = Wishlist.find_by(user_id: current_user.id)
    if check_product(params[:user_id], wishlist)
      redirect_to user_wishlist_path(current_user.id), notice: I18n.t(:wishlist_present)
    else
      wishlist.products << Product.find(params[:user_id])
      redirect_to user_wishlist_path(current_user.id), I18n.t(:wishlist_added)
    end
  end

  def show
    user = User.find(params[:user_id])
    wishlist = user.wishlist
    authorize wishlist
    @products = wishlist.products
  end

  def delete_product
    wishlist = current_user.wishlist
    authorize wishlist
    product = Product.find(params[:user_id])
    if wishlist.products.destroy(product)
      check_empty(wishlist)
    else
      redirect_to user_wishlist_path(current_user.id), alert: I18n.t(:wishlist_not_removed)
    end
  end
end
