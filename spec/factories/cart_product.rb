# frozen_string_literal: true

FactoryBot.define do
  factory :cart_product do
    total_price { 0 }
    quantity { 2 }
  end
end
