class UserInfo < ApplicationRecord
  belongs_to :user
  enum gender: { female:2, male:4 }

  validates :first_name, presence: true, length: { maximum: 50, message: "maximum of 50 characters" } 

  validates :surname, presence: true, length: { maximum: 50, message: "maximum of 50 characters" } 


end
