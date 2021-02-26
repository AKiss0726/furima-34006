class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:index, :create]

  def index
    @purchase_shipping = PurchaseShipping.new
  end

  def new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_params)
    if @purchase_shipping.valid?
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

end
