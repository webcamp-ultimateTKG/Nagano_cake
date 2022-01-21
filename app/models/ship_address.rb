class ShipAddress < ApplicationRecord
  belongs_to :customer

  validates :post_code, presence: true, format: { with: VALID_POST_CODE_REGEX }
  validates :address, presence: true
  validates :owner, presence: true, format: { with: VALID_NAME_REGEX }

  def full_address
    '〒' + post_code + ' ' + address + ' ' + owner
  end

end
