# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  let(:user) { FactoryBot.create(:user) }

  let(:cart) { FactoryBot.create(:cart, user_id: user.id) }

  let(:product) { FactoryBot.create(:product, user_id: user.id) }

  let(:product2) { FactoryBot.create(:product, user_id: user.id) }

  let(:cart_product) { FactoryBot.create(:cart_product, cart_id: cart.id, product_id: product.id) }
  let(:cart_product2) { FactoryBot.create(:cart_product, cart_id: cart.id, product_id: product2.id) }
  context 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:cart) }
  end

  describe 'to_paypal' do
    it 'it sets total price of a cart_product' do
      cart_products = [cart_product, cart_product2]
      items = cart_products.map(&:to_paypal)
      expect(items).to be_an_instance_of(Array)
    end
  end
end
