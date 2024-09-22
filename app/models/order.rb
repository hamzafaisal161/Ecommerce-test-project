# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user

  scope :all_orders, -> { where(user_id: user_id) }
end
