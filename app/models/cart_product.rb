class CartProduct < ApplicationRecord
  belongs_to :product
  
  #カートに商品を追加
  def add_product 
    product = Product.find_by(product_id: product_id) || Product.build(product_id: product_id)
    product.quantity += quantity.to_i
    product.save
  end
end
