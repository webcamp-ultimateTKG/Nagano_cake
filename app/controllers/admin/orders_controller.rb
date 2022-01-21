class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
    @total = @order_products.inject(0) { |sum, product| sum + product.subtotal }
  end

  def update
    @order = Order.find(params[:id])
    @order.status = params[:order][:status].to_i
    @order.update(order_params)
    @order_products = @order.order_products

    if @order.status == "payment_confirmation"
      @order_products.each do |order_product|
        order_product.making_status = "waiting"
        order_product.save
      end
    end
    redirect_to request.referer
  end

  def search
    @customer = Customer.find(params[:customer_id])
    @orders = Order.where(customer_id: params[:customer_id]).page(params[:page]).per(10)
  end

  private

    def order_params
      params.require(:order).permit(:status)
    end
end
