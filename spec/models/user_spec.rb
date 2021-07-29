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
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが必須であること。' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること。' do
        @user2 = FactoryBot.create(:user)
        @user.email = @user2.email
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、@を含む必要があること。' do
        @user.email = 'hogehoge'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること。' do
        @user.password = ''
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = 'xx2xx'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは、半角英字のみでは登録できないこと' do
        @user.password = 'xxxxxx'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must contain alphabets and numbers')
      end
      it 'パスワードは、半角数字のみでは登録できないこと' do
        @user.password = '111111'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must contain alphabets and numbers')
      end
      it 'パスワードは、全角文字では登録できないこと' do
        @user.password = 'アイウエオか'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must contain alphabets and numbers')
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること。' do
        @user.password_confirmation = 'xxxxxx'
        @user.password_confirmation = 'yyyyyy'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
    describe '新規登録/本人確認情報のバリデーション' do
      it 'お名前(全角)は、名字が必須であること。' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'お名前(全角)は、名前が必須であること。' do
        @user.given_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name can't be blank")
      end
      it 'お名前(全角)の名字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.family_name = Faker::Name.last_name
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name ONLY contains full-width characters')
      end
      it 'お名前(全角)の名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.given_name = Faker::Name.first_name
        @user.valid?
        expect(@user.errors.full_messages).to include('Given name ONLY contains full-width characters')
      end
      it 'お名前カナ(全角)は、名字が必須であること。' do
        @user.family_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family reading can't be blank")
      end
      it 'お名前カナ(全角)は、名前が必須であること。' do
        @user.given_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Given reading can't be blank")
      end
      it 'お名前カナ(全角)の名字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.family_reading = Faker::Name.last_name
        @user.valid?
        expect(@user.errors.full_messages).to include('Family reading ONLY contains full-width katakana characters')
      end
      it 'お名前カナ(全角)の名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.given_reading = Faker::Name.first_name
        @user.valid?
        expect(@user.errors.full_messages).to include('Given reading ONLY contains full-width katakana characters')
      end
      it '生年月日が必須であること。' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end