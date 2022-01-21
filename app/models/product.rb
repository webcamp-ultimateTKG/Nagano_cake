class Product < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_products
  has_many :order_products
  has_many :orders, through: :order_products

  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :genre_id, presence: true

  def add_tax_price
    (self.price * 1.10).round
  end

  def self.search(keyword)
    @product = Product.where("name LIKE?","%#{keyword}%")
  end

end
