# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "#{Faker::Name.unique.first_name}@gmail.com" }
    name { 'Hamza Faisal' }
    password { '123456' }
    password_confirmation { '123456' }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
    new_user { true }
  end
end
