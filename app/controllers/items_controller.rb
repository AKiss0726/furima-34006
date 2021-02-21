class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: [:edit]
  def index
    @items = Item.order('created_at DESC')
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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
     if @item.save
      redirect_to item_path
     else
      render :edit
     end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :price, :category_id, :condition_id, :allocation_id, :from_id, :to_ship_id,
                                 :description, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    @item = Item.find(params[:id])
     if current_user.id != @item.user.id
      redirect_to action: :index
     end
  end
end
