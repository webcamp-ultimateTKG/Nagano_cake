class CartProduct < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def subtotal
    product.add_tax_price * quantity
  end

end
