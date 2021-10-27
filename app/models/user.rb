class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #has_many :work_times
  has_many :accounts

  has_many :user_roles
  has_many :roles, through: :user_roles

  after_create :add_personal_account_to_user

  private

  def add_personal_account_to_user
    account = Account.create(user_id: self.id, name: "personal")
  end

end
