require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe '新規登録情報の入力' do
    it '正しい情報を入力すると、新規ユーザー登録できること' do
      expect(@user).to be_valid
    end
    describe '新規登録/ユーザー情報のバリデーション' do
      it 'ニックネームが必須であること。' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが必須であること。' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること。' do
        @user2 = FactoryBot.create(:user)
        @user.email = @user2.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
      it 'メールアドレスは、@を含む必要があること。' do
        @user.email = "hogehoge"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'パスワードが必須であること。' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = "xx2xx"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = "xxxxxxx"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must contain alphabets and numbers")
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること。' do
        @user.password_confirmation = "xxxxxxx"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
    describe '新規登録/本人確認情報のバリデーション' do
    end
  end
end