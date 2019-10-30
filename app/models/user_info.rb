class UserInfo < ApplicationRecord
  belongs_to :user
  enum gender: { female:2, male:4 }
end
