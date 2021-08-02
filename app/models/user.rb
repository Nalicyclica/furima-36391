class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :birthday
  end
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'ONLY contains full-width characters' } do
    validates :family_name
    validates :given_name
  end
  with_options presence: true, format: { with: /\A[ァ-ヴー]+\z/, message: 'ONLY contains full-width katakana characters' } do
    validates :family_reading
    validates :given_reading
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'must contain alphabets and numbers'

  has_many :items
  has_many :orders
end
