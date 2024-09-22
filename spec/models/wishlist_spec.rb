# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wishlist, type: :model do
  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:products) }
    it { is_expected.to belong_to(:user) }
  end
end
