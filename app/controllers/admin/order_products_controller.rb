class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!
  
  def create
  end
  
  private
  
    def order_product_params
    end
end
