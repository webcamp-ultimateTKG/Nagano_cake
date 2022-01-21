class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_product = OrderProduct.find(params[:id])
    @order = @order_product.order
    @order_products = @order.order_products
    @order_product.making_status = params[:order_product][:making_status].to_i
    @order_product.update(order_product_params)

    if @order_products.where(making_status: "making").count >= 1
      @order.status = "making"
      @order.save
    end

    if @order.order_products.count == @order_products.where(making_status: "completed").count
      @order.status = "shipping_preparation"
      @order.save
    end
    redirect_to request.referer
  end

  private

    def order_product_params
      params.require(:order_product).permit(:making_status)
    end
end
