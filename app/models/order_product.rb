class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def subtotal
    order_product.tax_in_price * quantity
  end
end
