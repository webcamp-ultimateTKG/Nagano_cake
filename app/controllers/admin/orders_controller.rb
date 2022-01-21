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
    @order = Order.find(params[:id])
    @order.status = params[:order][:status].to_i
    @order.update(order_params)
    @order_products = @order.order_products

    if @order.status == "入金確認"
      @order_products.each do |order_product|
        order_product.making_status = "製作待ち"
        order_product.save
      end
    end
    redirect_to request.referer
  end

  def search
  end

  private

    def order_params
      params.require(:order).permit(:status)
    end
end
