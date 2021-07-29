class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    binding.pry
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params_keys = [:title, :content, :category_id, :status_id, :delivery_pay_id, :prefecture_id, :expected_waiting_id, :price]
    params.require(:item).permit(params_keys).merge(user_id: current_user.id)
  end
end
