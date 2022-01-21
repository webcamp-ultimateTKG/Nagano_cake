class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :tax_in_price, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :making_status, presence: true

  def subtotal
    product.add_tax_price * quantity
  end

  enum making_status: {
   not_startable: 0,
   waiting: 1,
   making: 2,
   completed: 3
  }

end
