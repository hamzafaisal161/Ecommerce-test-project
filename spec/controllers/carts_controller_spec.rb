# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:cart) { FactoryBot.create(:cart, user_id: user.id) }
  let(:product) { FactoryBot.create(:product, user_id: user.id) }
  let(:product2) { FactoryBot.create(:product, user_id: user.id) }
  let(:cart_product) { FactoryBot.create(:cart_product, cart_id: cart.id, product_id: product.id) }

  before do
    request.env['devise.mappings'] = Devise.mappings[:user]
    sign_in user
  end

  describe 'GET /carts/id' do
    it 'tests the status of show method of the carts if cart is found' do
      get :show, params: { id: cart.id }
      template_render('show')
    end
  end

  describe 'GET /carts/id' do
    it 'tests the status of show method of the carts if cart is not found' do
      get :show, params: { id: 'a' }
      redirection(root_path)
    end
  end

  describe 'POST /carts/id/add_to_cart' do
    it 'tests the status of add_to_cart method of the carts if this cart_product does not exist' do
      post :add_to_cart,
           params: { cart_id: cart.id, product_id: product2.id, product_price: product2.price, quantity: 2 }
      redirection(cart_path(cart.id))
    end
  end

  describe 'POST /carts/id/add_to_cart' do
    it 'tests the status of add_to_cart method of the carts if this cart_product exists' do
      post :add_to_cart,
           params: { cart_id: cart.id, product_id: product.id, product_price: product.price,
                     quantity: cart_product.quantity }
      redirection(cart_path(cart.id))
    end
  end

  describe 'POST /carts/id/update_cart' do
    it 'tests the status of update_cart method of the carts if params are correct' do
      post :update_cart,
           params: { cart_id: cart.id, product_id: product.id, product_price: product.price,
                     quantity: cart_product.quantity }
      redirection(cart_path(cart.id))
    end
  end

  describe 'POST /carts/id/update_cart' do
    it 'tests the status of update_cart method of the carts if params are not correct' do
      post :update_cart,
           params: { cart_id: cart.id, product_id: product.id, product_price: product.price,
                     quantity: 'a' }
      redirection(root_path)
    end
  end

  describe 'POST /carts/id/update_cart' do
    it 'tests the status of update_cart method of the carts if cart_product is not found' do
      post :update_cart,
           params: { cart_id: cart.id, product_id: 'a', product_price: product.price,
                     quantity: cart_product.quantity }
      redirection(root_path)
    end
  end

  describe 'DELETE /carts/id/remove_from_cart' do
    it 'tests the status of remove_from_cart method of the carts if cart_product is found' do
      delete :remove_from_cart, params: { cart_id: cart_product.id }
      redirection(cart_path(cart.id))
    end
  end

  describe 'DELETE /carts/id/remove_from_cart' do
    it 'tests the status of remove_from_cart method of the carts if cart_product is not found' do
      delete :remove_from_cart, params: { cart_id: 'a' }
      redirection(root_path)
    end
  end
end
