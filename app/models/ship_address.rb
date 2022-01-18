class ShipAddress < ApplicationRecord
  belongs_to :customer

  validates :post_code, presence: true, numericality: { only_integr: true }
  validates :address, presence: true
  validates :owner, presence: true
end
