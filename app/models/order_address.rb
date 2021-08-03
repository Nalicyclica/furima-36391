class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_number, :prefecture_id, :city, :address, :apartment, :tel, :order_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id

    validates :post_number, format: { with: /\A\d{3}-\d{4}\z/, allow_blank: true, message: 'must be xxx-xxxx' }
    validates :prefecture_id
    validates :city
    validates :address
    validates :tel, format: { with: /\A\d{10,11}\z/, allow_blank: true, message: 'must be 10 or 11 digits number' }

    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_number: post_number, prefecture_id: prefecture_id, city: city, address: address, apartment: apartment,
                   tel: tel, order_id: order.id)
  end

  def ordered_item
    Item.find(item_id)
  end
end
