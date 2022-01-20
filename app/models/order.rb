class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products, through: :orders, source: :product, dependent: :destroy

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
