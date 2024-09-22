# frozen_string_literal: true

class Product < ApplicationRecord
  include ActiveModel::Dirty

  belongs_to :user
  has_many :comments, dependent: :delete_all
  has_and_belongs_to_many :wishlists # rubocop:disable Rails/HasAndBelongsToMany
  has_many :cart_products, dependent: :destroy
  has_many :carts, through: :cart_products
  has_many_attached :avatar

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }

  before_save :generate_email

  private

  def generate_email
    return unless price_changed?

    UserMailer.with(product: self).price_update_email.deliver_now
  end
end
