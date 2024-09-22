# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { should_not allow_value('123').for(:name) }
    it { should_not allow_value('test1').for(:name) }
  end
  context 'associations' do
    it { is_expected.to have_many(:orders).dependent(:delete_all) }
    it { is_expected.to have_many(:products).dependent(:delete_all) }
    it { is_expected.to have_many(:comments).dependent(:delete_all) }
    it { is_expected.to have_one(:wishlist).dependent(:delete) }
    it { is_expected.to have_one(:cart).dependent(:delete) }
    it { is_expected.to have_one_attached(:avatar) }
  end
end
