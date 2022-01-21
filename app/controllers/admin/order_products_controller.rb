class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_product = OrderProduct.find(params[:id])
    @order = @order_product.order
    @order_products = @order.order_products
    @order_product.making_status = params[:order_product][:making_status].to_i
    @order_product.update(order_product_params)

    if @order_products.where(making_status: "製作中").count >= 1
      @order.status = "製作中"
      @order.save
    end

    if @order.order_products.count == @order_products.where(making_status: "製作完了").count
       @order.status = "発送準備中"
       @order.save
    end
    redirect_to request.referer
  end

  private

    def order_product_params
      params.require(:order_product).permit(:making_status)
    end
end
