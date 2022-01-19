class Public::CartProductsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
  end
  
  def create
    @cart_product = CartProduct.new(cart_product_params)
    @product = Product.find(cart_product_params[:product_id])
    @cart_product.customer_id = current_customer.id
    #カートに選択した商品が既に存在するかどうか
    if CartProduct.find_by(product_id: @product)
      @cart_product.quantity += cart_product_params[:product_id].to_i
    else
      @cart_product.build(product_id: @product)
    end
    #カートに商品を保存する
    if @cart_product.save
      redirect_to cart_products_path
    else
      render "products/show"
    end
  end
  
  def update
  end
  
  def destroy
  end
  
  def destroy_all
  end
  
  private
    def cart_product_params
      params.require(:cart_prroduct).permit(:product_id, :quantity)
    end
    
end
