class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @address = current_customer.ship_addresses
  end

  def create
    session[:customer] = Order.new()
    session[:customer][:shipping_fee] = 800


    if params[:payment_method] == "0"
      session[:customer][:payment_method] = 0
    elsif params[:payment_method] == "1"
      session[:customer][:payment_method] = 1
    end


    if params[:address_select] == "0"
      session[:customer][:post_code] = current_customer.post_code
      session[:customer][:address] = current_customer.address
      session[:customer][:owner] = current_customer.full_name
    elsif params[:address_select] == "1"
      session[:customer][:post_code] =  ShipAddress.find(params[:address_id]).post_code
      session[:customer][:address] = ShipAddress.find(params[:address_id]).address
      session[:customer][:owner] = ShipAddress.find(params[:address_id]).owner
    elsif params[:address_select] == "2"
      session[:customer][:post_code] =  params[:post_code]
      session[:customer][:address] = params[:address]
      session[:customer][:owner] = params[:owner]
    end
    unless session[:customer][:address] == "" || session[:customer][:owner] == "" || session[:customer][:post_code] == ""
      redirect_to confirm_orders_path
    else
      @order = Order.new()
      @address = current_customer.ship_addresses
      render :new
    end
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
    cart_products = current_customer.cart_products
    session[:customer][:shipping_fee] = 800
    @total = 0
    cart_products.each do |cart_product|
      full_price = cart_product.product.add_tax_price * cart_product.quantity
      @total += full_price
    end
    order = Order.new(session[:customer])
    order.charge = @total + session[:customer][:shipping_fee].to_i
    order.customer_id = current_customer.id
    if order.save
    cart_products.each do |cart_product|
      order_product = OrderProduct.new
      order_product.product_id = cart_product.product.id
      order_product.tax_in_price = cart_product.product.add_tax_price.to_s
      order_product.quantity = cart_product.quantity
      order_product.order_id = order.id
      order_product.save
    end
      cart_products.destroy_all
    else
      redirect_to new_order_path
    end
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
