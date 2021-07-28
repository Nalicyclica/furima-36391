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
    end
    describe '新規登録/本人確認情報のバリデーション' do
    end
  end
end
