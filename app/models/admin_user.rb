class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  role_based_authorizable
  def self.ransackable_attributes(auth_object = nil)
    %w[id email created_at updated_at role first_name last_name] # Adjust attributes as needed
  end
end
