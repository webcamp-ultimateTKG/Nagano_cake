class Order < ApplicationRecord
  has_many :ordrer_products
  belongs_to :customer
end
