require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '入力内容に問題がなければ保存できる' do
      it '全ての情報が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end
      it 'apartmentは空欄でも保存できる' do
        @order_address.apartment = ''
        expect(@order_address).to be_valid
      end
    end
    context '入力内容に不備があると保存できない' do
      it '郵便番号が必須であること。' do
        @order_address.post_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post number can't be blank")
      end
      it '郵便番号は-入りの全角文字では保存できないこと。' do
        @order_address.post_number = 'あいう-えおかき'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post number must be xxx-xxxx')
      end
      it '郵便番号は-入りの半角英字では保存できないこと。' do
        @order_address.post_number = 'abc-defg'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post number must be xxx-xxxx')
      end
      it '郵便番号は-が入っていないとでは保存できないこと。' do
        @order_address.post_number = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post number must be xxx-xxxx')
      end
      it '郵便番号は-が入っていても桁数が合わないと保存できないこと。' do
        @order_address.post_number = '1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post number must be xxx-xxxx')
      end
      it '都道府県が必須であること。' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が必須であること。' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が必須であること。' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が必須であること。' do
        @order_address.tel = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel can't be blank")
      end
      it '電話番号は全角文字では保存できないこと。' do
        @order_address.tel = 'アイウエオかきくけこ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel must be 10 or 11 digits number')
      end
      it '電話番号は半角英字では保存できないこと。' do
        @order_address.tel = 'abcdefghij'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel must be 10 or 11 digits number')
      end
      it '電話番号は10-11桁でないと保存できないこと。' do
        @order_address.tel = '000011112222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel must be 10 or 11 digits number')
      end
      it '電話番号は-が入ると保存できないこと。' do
        @order_address.tel = '000-1111-2222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel must be 10 or 11 digits number')
      end
      it 'クレジット決済のトークンがないと保存できないこと。' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空だと保存できないこと。' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できないこと。' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
