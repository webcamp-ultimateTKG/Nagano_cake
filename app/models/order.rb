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

  enum status: {
   入金待ち: 0,
   入金確認: 1,
   製作中: 2,
   発送準備中: 3,
   発送済: 4
  }
end
