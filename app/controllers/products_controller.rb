# frozen_string_literal: true

class ProductsController < ApplicationController
  include ProductsConcern
  # before_action :authenticate_user!,
  #             except: %i[all_products show]

  def all_products
    @products = Product.all
  end

  def index
    user = User.find(params[:user_id])
    @products = user.products
  end

  def new
    user = User.find(params[:user_id])
    @product = user.products.build
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def update
    product = Product.find(params[:id])
    product.update!(update_product_params)
    if params[:product][:avatar].present?
      params[:product][:avatar].each do |image|
        product.avatar.attach(image)
      end
    end
    redirect_to product_path, notice: I18n.t(:product_update_success)
  end

  def destroy
    product = Product.find(params[:id])
    authorize product
    product.destroy!
    redirect_to products_path, notice: I18n.t(:product_destroy_success)
  end

  def create
    product = current_user.products.create!(product_params)
    if params[:product][:avatar].present?
      params[:product][:avatar].each do |image|
        product.avatar.attach(image)
      end
    end
    product.save!
    redirect_to product_path(product), notice: I18n.t(:product_create_success)
  end

  def show
    @product = Product.find(params[:id])
    @comment = Comment.new
    @comments = @product.comments.order('created_at DESC')
    # authorize @product, policy_class: CommentPolicy
  end

  private

  def product_params
    serial = gen_serial
    params.require(:product).permit(:name, :description, :price).merge(serial_no: serial)
  end

  def update_product_params
    params.require(:product).permit(:name, :description, :price, :serial_no)
  end
end
