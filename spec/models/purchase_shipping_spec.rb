require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_shipping = FactoryBot.build(:purchase_shipping, user_id: @user.id, item_id: @item.id)
  end

  describe '購入履歴、配送先の保存' do
    context '保存できる時' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_shipping).to be_valid
      end
    end

    context '保存できない時' do
      it 'zip(郵便番号)が空では保存できないこと' do
        @purchase_shipping.zip = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Zip can't be blank")
      end

      it 'zip(郵便番号)が半角ハイフンを含まない形式では保存できないこと' do
        @purchase_shipping.zip = '1234567'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Zip is invalid. Include hyphen(-)')
      end

      it 'from_id(都道府県)を選択していないと保存できないこと' do
        @purchase_shipping.from_id = 1
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('From select')
      end

      it 'delivery_municipality(市区町村)が空では保存できないこと' do
        @purchase_shipping.delivery_municipality = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Delivery municipality can't be blank")
      end

      it 'delivery_municipality(市区町村)が全角かな/カナ、漢字でなければ登録できないこと' do
        @purchase_shipping.delivery_municipality = 'testﾃｽﾄ'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Delivery municipality is invalid. Input full-width characters.')
      end

      it 'delivery_street(番地)が空では保存できないこと' do
        @purchase_shipping.delivery_street = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Delivery street can't be blank")
      end

      it 'delivery_building(建物名)が空でも保存できること' do
        @purchase_shipping.delivery_building = ''
        expect(@purchase_shipping).to be_valid
      end

      it 'tel(電話番号)が空では保存できないこと' do
        @purchase_shipping.tel = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Tel can't be blank")
      end

      it 'tel(電話番号)は11桁以内の数値しか保存できないこと(文字)' do
        @purchase_shipping.tel = 'あいうえお'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Tel input only number')
      end

      it 'tel(電話番号)は11桁以内の数値しか保存できないこと(数値11桁以上)' do
        @purchase_shipping.tel = '123456789123456789'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include('Tel input only number')
      end

      it 'tokenが空では保存できないこと' do
        @purchase_shipping.token = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
