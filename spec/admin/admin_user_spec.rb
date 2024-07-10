require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe Admin::AdminUsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  render_views

  before(:each) do
    @admin = FactoryBot.create(:admin_user, email: 'admin@example.com')
    sign_in @admin
    @admin_user = FactoryBot.create(:admin_user, email: 'user@example.com')
  end

  describe 'GET #index' do
    it 'returns all admin users' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template('index')
      expect(assigns(:admin_users)).to include(@admin_user)
    end
  end

  describe 'GET #show' do
    it 'returns a single admin user' do
      get :show, params: { id: @admin_user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template('show')
      expect(assigns(:admin_user)).to eq(@admin_user)
    end
  end

  describe 'GET #new' do
    it 'returns a new admin user form' do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template('new')
      expect(assigns(:admin_user)).to be_a_new(AdminUser)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        admin_user: {
          first_name: 'Jane',
          last_name: 'Doe',
          email: 'jane.doe@example.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'admin'
        }
      }
    end

    it 'creates a new admin user with valid params' do
      expect {
        post :create, params: valid_params
      }.to change(AdminUser, :count).by(1)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_admin_user_path(AdminUser.last))
    end
  end

  describe 'GET #edit' do
    it 'returns the edit form for an admin user' do
      get :edit, params: { id: @admin_user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template('edit')
      expect(assigns(:admin_user)).to eq(@admin_user)
    end
  end

  describe 'PATCH #update' do
    let(:valid_update_params) do
      {
        id: @admin_user.id,
        admin_user: {
          first_name: 'John',
          last_name: 'Smith'
        }
      }
    end

    it 'updates an admin user with valid params' do
      patch :update, params: valid_update_params
      @admin_user.reload
      expect(@admin_user.first_name).to eq('John')
      expect(@admin_user.last_name).to eq('Smith')
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_admin_user_path(@admin_user))
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes an admin user' do
      expect {
        delete :destroy, params: { id: @admin_user.id }
      }.to change(AdminUser, :count).by(-1)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(admin_admin_users_path)
    end
  end
end
