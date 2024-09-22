# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :products, dependent: :delete_all
  has_one :wishlist, dependent: :delete
  has_one :cart, dependent: :delete

  has_one_attached :avatar, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :name, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: I18n.t(:only_letters) }
end
