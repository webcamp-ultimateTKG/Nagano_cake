class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @address = current_customer.ship_addresses
  end

  def create
    session[:user] = Order.new()

    #支払い方法のセッション情報
    if params[:payment_select] == "0"
      session[:user][:payment_method] = 0
    elsif params[:payment_select] == "1"
      session[:user][:payment_method] = 1
    end

    #配送先登録のセッション情報
    if params[:address_select] == "0"
      session[:user][:post_code] = current_customer.post_code
      session[:user][:address] = current_customer.address
      session[:user][:address_owner] = current_customer.full_name
    elsif params[:address_select] == "1"
      session[:user][:post_code] =  ShipAddress.find(params[:address_id]).post_code
      session[:user][:address] = ShipAddress.find(params[:address_id]).address
      session[:user][:address_owner] = ShipAddress.find(params[:address_id]).owner
    else
      session[:user][:post_code] =  params[:postal_code]
      session[:user][:address] = params[:shipping_address]
      session[:user][:address_owner] = params[:direction]
    end
    session[:user][:shipping_fee] = 800
    redirect_to confirm_orders_path
  end

  def confirm
  end

  def thanx
  end

  def index
  end

  def show
  end

  private

    def order_params
      params.require(:order).permit(:customer_id, :payment_method, :post_code, :address, :address_owner, :charge, :status, :shipping_fee)
    end

end
