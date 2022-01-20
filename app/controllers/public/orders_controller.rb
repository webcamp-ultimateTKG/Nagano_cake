class Public::OrdersController < ApplicationController
  def new
  end

  def confirm
  end

  def create
  end

  def thanx
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
  end
end
