require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品できる時' do
      it 'item_name、description、category_id、condition_id、allocation_id、from_id、to_ship_id、price、user、imageが存在すれば出品できること' do
        expect(@item).to be_valid
      end
    end

    context '出品できない時' do
      it 'item_name(商品名)が空では出品できないこと' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it 'description(商品説明)が空では出品できないこと' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'category_id(カテゴリー)が空では出品できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it 'condition_id(商品の状態)が空では出品できないこと' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end

      it 'allocation_id(配送料の負担)が空では出品できないこと' do
        @item.allocation_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Allocation must be other than 1')
      end

      it 'from_id(発送元)が空では出品できないこと' do
        @item.from_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('From must be other than 1')
      end

      it 'to_ship_id(発送までの日数)が空では出品できないこと' do
        @item.to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('To ship must be other than 1')
      end

      it 'price(値段)が空では出品できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'price(値段)を全角で入力しても出品できないこと' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'price(値段)を英数混合で入力しても出品できないこと' do
        @item.price = '500yen'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'price(値段)を英字のみで入力しても出品できないこと' do
        @item.price = 'abcde'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'price(値段)が¥299円以下では出品できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it 'price(値段)が¥10,000,000円以上では出品できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it 'image(商品画像)が無ければ出品できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end
