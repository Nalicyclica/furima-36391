class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find
  before_action :item_order_restriction
  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      credit_pay(@order_address)
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params_key = [:post_number, :prefecture_id, :city, :address, :apartment, :tel]
    params.require(:order_address).permit(params_key).merge(user_id: current_user.id, item_id: params[:item_id],
                                                            token: params[:token])
  end

  def credit_pay(order_address)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: order_address.ordered_item.price,
      card: order_address.token,
      currency: 'jpy'
    )
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def item_order_restriction
    redirect_to root_path if @item.user.id == current_user.id || @item.order.present?
  end
end
