class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
  end
  
  def show
  end
  
  def update
  end
  
  def search
  end
  
  private
  
    def order_params
    end
end
