class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/ #ひらがな、カタカナ、漢字
  VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/    #カタカナ
  VALID_POST_CODE_REGEX = /\A\d{7}\z/      #7桁の数字
  VALID_EMAIL_REGEX = /\A\S+@\S+\.\S+\z/     #アルファベット、＠、ドット
  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/ #9 ot 10桁の数字
end
