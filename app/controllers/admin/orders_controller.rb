class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
  end

  def update
    order = Order.find(params[:id])
    order.status = params[:status].to_i
    order.save
    redirect_to order_path(order)
  end

  def search
    @customer = Customer.find(params[:customer_id])
    @orders = Order.where(customer_id: params[:customer_id]).page(params[:page]).per(10)
  end

  private

    def order_params
      params.require(:order).permit(:payment_method, :post_code, :address, :owner, :shipping_fee, :charge, :status)
    end
end
