class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def order_params
    params_key = [:post_number, :prefecture_id, :city, :address, :apartment, :tel]
    params.require(:order_address).permit(params_key).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
