class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  validates :customer_id, presence: :true
  validates :post_code, presence: :true
  validates :address, presence: :true
  validates :owner, presence: :true
  validates :shipping_fee, presence: :true
  validates :charge, presence: :true

  def total_quantity
    self.order_products.all.sum(:quantity)
  end

  enum payment_method: {
    credit_card: 0,
    transfer: 1
  }

  enum status: {
    waiting: 0,
    payment_confirmation: 1,
    making: 2,
    shipping_preparation: 3,
    shipped: 4
  }

end
