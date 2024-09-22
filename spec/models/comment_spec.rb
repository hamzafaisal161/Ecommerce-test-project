# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:description) }
  end
  context 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many_attached(:avatar) }
  end
end
