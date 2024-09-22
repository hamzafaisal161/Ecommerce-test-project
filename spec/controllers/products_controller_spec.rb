# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
  let(:user) { User.last }
  let(:cart) { FactoryBot.create(:cart, user_id: user.id) }
  let(:product) { FactoryBot.create(:product, user_id: user.id) }

  before do
    request.env['devise.mappings'] = Devise.mappings[:user]
    sign_in user
  end

  describe 'GET /products' do
    it 'tests the status of all_products method of the products' do
      get :all_products
      template_render('all_products')
    end
  end

  describe 'GET /users/id/products' do
    it 'tests the status of index method of the products if user is present' do
      get :index, params: { user_id: user.id }
      template_render('index')
    end
  end

  describe 'GET /users/id/products' do
    it 'tests the status of index method of the products if user is not present' do
      get :index, params: { user_id: 'a' }
      redirection(root_path)
    end
  end

  describe 'GET /users/id/products/new' do
    it 'tests the status of new method of the products if user is present' do
      get :new, params: { user_id: user.id }
      template_render('new')
    end
  end

  describe 'GET /users/id/products/new' do
    it 'tests the status of new method of the products if user is not present' do
      get :new, params: { user_id: 'a' }
      redirection(root_path)
    end
  end

  describe 'GET /products/id/edit' do
    it 'tests the status of edit method of the products if product is found' do
      get :edit, params: { id: product.id }
      template_render('edit')
    end
  end

  describe 'GET /products/id/edit' do
    it 'tests the status of edit method of the products if product is not found' do
      get :edit, params: { id: 'a' }
      redirection(root_path)
    end
  end

  describe 'GET /product/id' do
    it 'tests the status of show method of the product if product is found' do
      get :show, params: { id: product.id }
      template_render('show')
    end
  end

  describe 'GET /product/id' do
    it 'tests the status of show method of the product if product is not found' do
      get :show, params: { id: 'a' }
      redirection(root_path)
    end
  end

  describe 'PATCH /product/id' do
    it 'tests the status of update method of the product if product is found' do
      patch :update, params: { id: product.id,
                               product: { name: 'changed', description: 'changed product', price: 200,
                                          avatar: [fixture_file_upload(Rails.root.join('app/assets/images/default.jpg'),
                                                                       'image/jpeg')] } }
      redirection(product_path)
    end
  end

  describe 'PATCH /product/id' do
    it 'tests the status of update method of the product if product is not found' do
      patch :update, params: { id: 'a',
                               product: { name: 'changed', description: 'changed product', price: 200,
                                          avatar: [fixture_file_upload(Rails.root.join('app/assets/images/default.jpg'),
                                                                       'image/jpeg')] } }
      redirection(root_path)
    end
  end

  describe 'DELETE /product/id' do
    it 'tests the status of delete method of the product if product is found' do
      delete :destroy, params: { id: product.id }
      redirection(products_path)
    end
  end

  describe 'DELETE /product/id' do
    it 'tests the status of delete method of the product if product is not found' do
      delete :destroy, params: { id: 'a' }
      redirection(root_path)
    end
  end

  describe 'POST /products' do
    it 'tests the status of create method of the product if params are valid' do
      post :create,
           params: { product: { name: 'test product', description: 'created using spec', price: 100,
                                avatar: [fixture_file_upload(Rails.root.join('app/assets/images/default.jpg'),
                                                             'image/jpeg')] },
                     user_id: user.id }
      id = product.id - 1
      redirection(product_path(id))
    end
  end

  describe 'POST /products' do
    it 'tests the status of create method of the product if params are not valid' do
      post :create, params: { product: { name: 'test product', description: 'created using spec', user_id: user.id } }
      redirection(root_path)
    end
  end
end
