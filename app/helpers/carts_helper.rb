# frozen_string_literal: true

module CartsHelper
  def get_product(id)
    Product.find(id)
  end
end
