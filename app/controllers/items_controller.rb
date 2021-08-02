class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :item_find, only: [:show, :edit, :update]
  before_action :not_item_owner, only: [:edit, :update]

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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params_keys = [:title, :content, :category_id, :status_id, :delivery_pay_id, :prefecture_id, :expected_waiting_id, :price,
                   :image]
    params.require(:item).permit(params_keys).merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def not_item_owner
    redirect_to root_path unless @item.user_id == current_user.id
  end
end
