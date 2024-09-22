# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:products).through(:cart_products) }
    it { is_expected.to have_many(:cart_products).dependent(:destroy) }
  end
end
