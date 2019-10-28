class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_one :order_line
  has_one_attached :picture
  has_one_attached :receipt
  enum used: { no:0, yes:1 }

end
