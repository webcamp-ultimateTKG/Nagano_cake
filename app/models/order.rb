class Order < ApplicationRecord


  belongs_to :customer
  has_many :order_products, dependent: :destroy

  validates :customer_id, presence: :true
  validates :post_code, presence: :true
  validates :address, presence: :true
  validates :owner, presence: :true
  validates :shipping_fee, presence: :true
  validates :charge, presence: :true

end
