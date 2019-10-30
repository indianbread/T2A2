class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_one :order_line
  has_one_attached :picture
  has_one_attached :receipt
  has_many :product_ingredients
  has_many :ingredients, through: :product_ingredients
  enum used: { no:0, yes:1 }
  accepts_nested_attributes_for :ingredients, :brand, :category
end
