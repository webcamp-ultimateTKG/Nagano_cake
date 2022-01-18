class Admin::ProductsController < ApplicationController
  before_action :move_to_signed_in
  before_action :set_product, only[:new, :create, :edit, :update]

  def new
    @prodcut = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:genre_id, :name, :introduction, :price, :is_active)
  end

  def move_to_signed_in
    unless admin_signed_in?
      #管理者ログインしていない場合はtopページに行く
      redirect_to root_path
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
