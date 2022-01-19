class CartProduct < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  def subtotal
    product.add_tax_price * quantity
  end

end
