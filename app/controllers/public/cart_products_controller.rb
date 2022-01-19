class Public::CartProductsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_products = CartProduct.where(customer_id: current_customer.id)
  end

  def create
    @cart_product = current_customer.cart_products.new(cart_product_params)
    @cart_product.product_id = params[:cart_product][:product_id]
    mycart = CartProduct.where(customer_id: current_customer.id)
    #選択した商品が既にカート内に存在する場合
    if mycart.find_by(params[:product_id])
      @cart_product.quantity += params[:cart_product][:quantity].to_i
      @cart_product.update(cart_product_params)
      redirect_to cart_products_path
    #選択した商品がカート内に存在しない場合
    else
      @cart_product.save
      redirect_to cart_products_path
    end

  end

  def update
  end

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy
    redirect_to cart_products_path
  end

  def destroy_all
  end

  private
    def cart_product_params
      params.require(:cart_product).permit(:product_id, :quantity)
    end

end
