class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase, only: [:index, :create, :move_to_index]
  before_action :move_to_index
  def index
    @purchase_shipping = PurchaseShipping.new
  end

  def new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_params)
    if @purchase_shipping.valid?
      pay_item
      @purchase_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def purchase_params
    params.require(:purchase_shipping).permit(:zip, :from_id, :delivery_municipality, :delivery_street, :delivery_building, :tel).merge(token: params[:token], item_id: @item.id, user_id: current_user.id)
  end

  def set_purchase
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = "sk_test_1b5d484e4b6d6270f4c79ffa"
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
  end

  def move_to_index
    unless @item.user_id != current_user.id
      redirect_to root_path
    end
  end

end
