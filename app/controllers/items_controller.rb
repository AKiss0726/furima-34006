class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @item = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :price, :category_id, :condition_id, :allocation_id, :from_id, :to_ship_id,
                                 :description, :image).merge(user_id: current_user.id)
  end
end
