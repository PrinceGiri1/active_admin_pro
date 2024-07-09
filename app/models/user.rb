class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy


  def admin?
    self.role == 'admin'
  end

  def sub_admin?
    self.role == 'sub_admin'
  end

  def manager?
    self.role == 'manager'
  end

  def supervisor?
    self.role == 'supervisor'
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
