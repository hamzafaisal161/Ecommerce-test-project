# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many_attached :avatar

  validates :description, presence: true
end
