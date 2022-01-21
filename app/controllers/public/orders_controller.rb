class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @address = current_customer.ship_addresses
  end

  def create
    order = Order.new(order_params)
    cart_products = current_customer.cart_products
    @total = 0
    cart_products.each do |cart_product|
      full_price = cart_product.product.add_tax_price * cart_product.quantity
      @total += full_price
    end
    order.charge = @total + params[:order][:shipping_fee].to_i
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
      redirect_to thanx_orders_path
    else
      redirect_to new_order_path
    end
  end

  def confirm
    @order = Order.new
    if params[:order][:address_select] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.owner = current_customer.full_name
    elsif params[:order][:address_select] == "1"
      @order.post_code =  ShipAddress.find(params[:order][:address_id]).post_code
      @order.address = ShipAddress.find(params[:order][:address_id]).address
      @order.owner = ShipAddress.find(params[:order][:address_id]).owner
    elsif params[:order][:address_select] == "2"
      @order.post_code =  params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.owner = params[:order][:owner]
    end

    @order.payment_method = params[:order][:payment_method]
    @order.shipping_fee = 800

    @cart_products = current_customer.cart_products
    @total = 0
    @cart_products.each do |cart_product|
      full_price = cart_product.product.add_tax_price * cart_product.quantity
      @total += full_price
    end
    unless @order.post_code == "" || @order.address == "" || @order.owner == ""
    render :confirm
    else
    @order = Order.new
    @address = current_customer.ship_addresses
    render :new
    end
  end

  def thanx
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_products = @order.order_products
    @total = @order_products.inject(0) { |sum, product| sum + product.subtotal }
  end

  private

    def order_params
      params.require(:order).permit(:customer_id, :payment_method, :post_code, :address, :owner, :charge, :status, :shipping_fee)
    end

end
