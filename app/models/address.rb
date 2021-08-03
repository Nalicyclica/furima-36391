class Address < ApplicationRecord
  with_options presence: true do
    validates :post_number
    validates :prefecture_id
    validates :city
    validates :address

    validates :tel
    validates :order
  end

  belongs_to :order
end
