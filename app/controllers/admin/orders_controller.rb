class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
  end

  def search
  end

  private

    def order_params
      params.require(:order).permit(:payment_method, :post_code, :address, :owner, :shipping_fee, :charge, :status)
    end
end
