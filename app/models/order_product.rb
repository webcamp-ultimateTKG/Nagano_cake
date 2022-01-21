class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

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
