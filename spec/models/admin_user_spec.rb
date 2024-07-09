require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'Devise modules' do
    it 'is database authenticatable' do
      admin_user = AdminUser.new(email: 'test@example.com', password: 'password')
      expect(admin_user.valid_password?('password')).to be_truthy
    end

    it 'is recoverable' do
      admin_user = AdminUser.new(email: 'test@example.com', password: 'password', reset_password_token: 'token')
      expect(admin_user.reset_password_token).to eq('token')
    end

    it 'is rememberable' do
      admin_user = AdminUser.new(email: 'test@example.com', password: 'password', remember_created_at: Time.now)
      expect(admin_user.remember_created_at).to_not be_nil
    end

    it 'is validatable' do
      admin_user = AdminUser.new(email: 'test@example.com', password: 'password')
      expect(admin_user.valid?).to be_truthy
    end
  end

  describe 'role_based_authorizable' do
    it 'responds to role_based_authorizable method' do
      expect(AdminUser).to respond_to(:role_based_authorizable)
    end
  end

  describe '.ransackable_attributes' do
    it 'returns the searchable attributes' do
      searchable_attributes = AdminUser.ransackable_attributes
      expect(searchable_attributes).to include('id', 'email', 'created_at', 'updated_at', 'role', 'first_name', 'last_name')
    end
  end
end
