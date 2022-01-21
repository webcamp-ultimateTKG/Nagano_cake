class Public::HomesController < ApplicationController
  before_action :set_products, only: [:top]

  def top
    @genres = Genre.all
    @products = @new_products.first(4)
  end

  def about
  end

  private
  def set_products
    @new_products = Product.all.order('created_at DESC')
  end

end
