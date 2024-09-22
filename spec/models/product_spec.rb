# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }
  end
  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:wishlists) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:delete_all) }
    it { is_expected.to have_many(:cart_products).dependent(:destroy) }
    it { is_expected.to have_many(:carts).through(:cart_products) }
    it { is_expected.to have_many_attached(:avatar) }
  end
  context 'callbacks' do
    it {  is_expected.to callback(:generate_email).before(:save) }
  end
  context 'generate_email' do
    it { expect(ActionMailer::Base.deliveries.count).to eq(0) }
  end
end
