class Item < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :content
    validates :category_id
    validates :status_id
    validates :delivery_pay_id
    validates :prefecture_id
    validates :expected_waiting_id
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than: 10_000_000, allow_nil: true,
                              message: 'is out of range or invalid' }
    validates :user_id
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_pay
  belongs_to :prefecture
  belongs_to :expected_waiting

  belongs_to :user
  has_one_attached :image
end
