class ShippingAddress < ApplicationRecord
  belongs_to :customer
  
  validates :post_code, presence: true
  validates :address, presence: true
  validates :owner, presence: true
end
