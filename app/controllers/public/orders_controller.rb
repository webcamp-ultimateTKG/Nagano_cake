class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @address = current_customer.ship_addresses
  end

  def create
    session[:user] = Order.new()
    session[:user][:shipping_fee] = 800


    if params[:payment_select] == "0"
      session[:user][:payment_method] = 0
    elsif params[:payment_select] == "1"
      session[:user][:payment_method] = 1
    end


    if params[:address_select] == "0"
      session[:user][:post_code] = current_customer.post_code
      session[:user][:address] = current_customer.address
      session[:user][:owner] = current_customer.full_name
    elsif params[:address_select] == "1"
      session[:user][:post_code] =  ShipAddress.find(params[:address_id]).post_code
      session[:user][:address] = ShipAddress.find(params[:address_id]).address
      session[:user][:owner] = ShipAddress.find(params[:address_id]).owner
    else
      session[:user][:post_code] =  params[:post_code]
      session[:user][:address] = params[:address]
      session[:user][:owner] = params[:owner]
    end

    redirect_to confirm_orders_path
  end

  def confirm
    @cart_products = current_customer.cart_products
    @total = 0
    @cart_products.each do |cart_product|
      full_price = cart_product.product.add_tax_price * cart_product.quantity
      @total += full_price
    end

  end

  def thanx
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_products = @orders.order_products
    @total = @order_products.inject(0) { |sum, product| sum + order_product.subtotal }
  end

  private

    def order_params
      params.require(:order).permit(:customer_id, :payment_method, :post_code, :address, :owner, :charge, :status, :shipping_fee)
    end

end
