require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '新規登録情報の入力' do
    it '正しい情報を入力すると、商品登録できること' do
      expect(@item).to be_valid
    end
    describe '商品登録情報のバリデーション' do
      it '商品名が必須であること。' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end
      it '商品の説明が必須であること。' do
        @item.content = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it 'カテゴリーの情報が必須であること。' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態の情報が必須であること。' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it '配送料の負担の情報が必須であること。' do
        @item.delivery_pay_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery pay can't be blank")
      end
      it '発送元の地域の情報が必須であること。' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数の情報が必須であること。' do
        @item.expected_waiting_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Expected waiting can't be blank")
      end
      it '価格の情報が必須であること。' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '¥300より低い価格では保存不可であること。' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of range or invalid')
      end
      it '¥10,000,000以上の価格では保存不可であること。' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of range or invalid')
      end
      it '価格は、半角数字以外の文字列では保存不可であること。' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of range or invalid')
      end
      it '商品画像を1枚つけることが必須であること。' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Image must be attached')
      end
    end
  end
end
