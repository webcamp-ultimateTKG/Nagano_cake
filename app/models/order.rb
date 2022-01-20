class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products, through: :orders, source: :product, dependent: :destroy
end
