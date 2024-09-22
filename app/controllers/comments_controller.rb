# frozen_string_literal: true

class CommentsController < ApplicationController
  include CommentsConcern
  before_action :load_product

  def create
    @comment = @product.comments.create!(description: params[:comment][:description], user_id: current_user.id,
                                         product_id: @product.id)
    if params[:comment][:file].present?
      params[:comment][:file].each do |image|
        @comment.avatar.attach(image)
      end
    end
    @comment.save!
  end

  def destroy
    @comment = @product.comments.find(params[:id])
    @comment_id = @comment.id
    redirect_to products_path, notice: I18n.t(:comment_destroy_fail) unless @comment.destroy
  end

  def edit
    @comment = @product.comments.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment = @product.comments.find(params[:id])
    if @comment.update!(description: params[:comment][:description])
      attach_avatar(params[:comment][:file], @comment)
      redirect_to product_path(@product), notice: I18n.t(:comment_update_success)
    else
      redirect_to product_path(@product), alert: I18n.t(:comment_update_fail)
    end
  end

  private

  def load_product
    @product = Product.find(params[:product_id])
  end
end
