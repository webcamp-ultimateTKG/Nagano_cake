class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_many :cart_products
  has_many :ship_addresses, dependent: :destroy
  has_many :orders

  VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/
  VALID_POST_CODE_REGEX = /\A\d{7}\z/
  VALID_EMAIL_REGEX = /\A\S+@\S+\.\S+\z/
  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true, format: { with:VALID_KANA_REGEX }
  validates :last_name_kana, presence: true, format: { with:VALID_KANA_REGEX }
  validates :email, presence: true, uniqueness: true, format: { with:VALID_EMAIL_REGEX }
  validates :post_code, presence: true, format: { with:VALID_POST_CODE_REGEX }
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with:VALID_PHONE_NUMBER_REGEX }

  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end

end
