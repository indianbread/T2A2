class UserInfo < ApplicationRecord
  belongs_to :user
  enum gender: { female:0, male:1 }
end
