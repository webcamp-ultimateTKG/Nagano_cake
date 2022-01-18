class Product < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_products
  has_many :order_products

  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: {only_integer: true}
  validates :genre_id, presence: true
  validates :is_active, presence: true


  def add_tax_price
      (self.price * 1.10).round
  end
end
