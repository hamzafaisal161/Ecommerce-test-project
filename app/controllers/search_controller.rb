# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    return unless params[:q].present? || params[:name_or_description_cont].present?

    product_params = params[:name_or_description_cont] || params[:q][:name_or_description_cont]
    @query = Product.ransack(name_or_description_cont: product_params)
    @products = @query.result(distinct: true)
  end
end
