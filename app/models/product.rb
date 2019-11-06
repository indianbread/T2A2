class Product < ApplicationRecord
 
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_one :order_line
  has_one_attached :picture
  has_one_attached :receipt
  has_many :product_ingredients, :dependent => :destroy
  has_many :ingredients, through: :product_ingredients
  serialize :ingredients
  enum used: { no:0, yes:1 }
  accepts_nested_attributes_for :ingredients, :brand, :category
  validates :brand, length: { in: 1..60, message: "must be between 1 and 60 characters"  }
  validates :name, length: { in: 3..60, message: "must be between 3 and 60 characters"  }
  validates :description, length: { in: 20..255, message: "must be between 20 and 255 characters" }
  validates :price, numericality: { greater_than_or_equal_to: 5, message: "must be at least $5"  }
  validates :name, :description, :category, :brand, :used, :price, :picture, presence: true 
  validates :expiry_date, :receipt, presence: true, if: Proc.new { |product| product.used == 'yes'}
  

end
