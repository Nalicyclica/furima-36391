FactoryBot.define do
  factory :item do
    title { Faker::Commerce.product_name }
    content { Faker::Lorem.sentence }
    category_id { Faker::Number.within(range: 0..9) }
    status_id { Faker::Number.within(range: 0..5) }
    delivery_pay_id { Faker::Number.within(range: 0..1) }
    prefecture_id { Faker::Number.within(range: 0..46) }
    expected_waiting_id { Faker::Number.within(range: 0..2) }
    price { Faker::Number.within(range: 300..9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/item_test.png'), filename: 'item_test.png', content_type: 'image/png')
    end
  end
end
