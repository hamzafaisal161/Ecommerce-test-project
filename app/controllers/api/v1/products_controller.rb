# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApiController
      def all_products
        @products = Product.all
        render json: @products
      end

      def index
        user = User.find(params[:user_id])
        @products = user.products
        render json: @products
      end

      def show
        @product = Product.find(params[:id])
        render json: @product
      end
    end
  end
end
