class Public::CartProductsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_products = CartProduct.where(customer_id: current_customer.id)
  end

  def create
    @cart_product = current_customer.cart_products.new(cart_product_params)
    @cart_product.product_id = params[:cart_product][:product_id]
    current_cart_product = current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id])
    #選択した商品が既にカート内に存在する場合
    if current_cart_product.present?
      current_cart_product.quantity += params[:cart_product][:quantity].to_i
      current_cart_product.save
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
