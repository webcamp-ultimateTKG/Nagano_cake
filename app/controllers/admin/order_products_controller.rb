class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    order_product = OrderProduct.find(params[:id])
    order_product.making_status = params([:making_status]).to_i
    order_product.save
    redirect_to order_path(order)
  end

  private

    def order_product_params
      params.require(:product_id, :tax_in_price, :quantity, :making_status)
    end
end
