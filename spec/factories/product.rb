# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { 'Product 1' }
    description { 'test' }
    price { 100 }
    serial_no { '123456' }
  end
end
