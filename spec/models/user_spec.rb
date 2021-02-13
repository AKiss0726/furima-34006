require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it 'nickname、email、password、password_confirmation、family_name、first_name、furigana_family_name、furigana_first_name、birthdayが存在すれば登録できること' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない時' do
      it 'nicknameが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailに@が含まれていること' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'password_confirmationが空であれば登録できないこと' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '名前の姓が空では登録できないこと' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it '名前の名が空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '名前の姓のフリガナが空では登録できないこと' do
        @user.furigana_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana family name can't be blank")
      end

      it '名前の名のフリガナが空では登録できないこと' do
        @user.furigana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Furigana first name can't be blank")
      end

      it '生年月日が必須であること' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it 'passwordが5文字以下であれば登録できないこと' do
        @user.password = '999so'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '999sos'
        @user.password_confirmation = '808tr'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが英数混合でなければ登録できないこと(英字)' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordが英数混合でなければ登録できないこと(数字)' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'passwordが半角英数混合でなければ登録できないこと(含:全角)' do
        @user.password = 'ｔｒ909r'
        @user.password_confirmation = 'ｔｒ909r'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it '名前の姓が全角かな/カナ、漢字でなければ登録できないこと' do
        @user.family_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid')
      end

      it '名前の名が全角かな/カナ、漢字でなければ登録できないこと' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it '名前の姓のフリガナが全角カナでなければ登録できないこと' do
        @user.furigana_family_name = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('Furigana family name is invalid')
      end

      it '名前の名のフリガナが全角カナでなければ登録できないこと' do
        @user.furigana_first_name = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('Furigana first name is invalid')
      end
    end
  end
end
