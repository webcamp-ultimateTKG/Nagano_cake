class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
  end

  private

    def order_product_params
      params.require(:product_id, :tax_in_price, :quantity, :making_status)
    end
end
