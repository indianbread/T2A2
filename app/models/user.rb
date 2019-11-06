class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :user_info, :dependent => :destroy
  has_many :products
  has_many :orders
  has_many :addresses, :dependent => :destroy

  accepts_nested_attributes_for :user_info, :addresses, :orders


end
