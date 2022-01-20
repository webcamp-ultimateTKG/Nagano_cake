class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products, through: :orders, source: :product, dependent: :destroy

  def total_quantity
    self.order_products.all.sum(:quantity)
  end
end
