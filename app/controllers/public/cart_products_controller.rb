class Public::CartProductsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
  end
  
  def create
    @cart_product = CartProduct.new(cart_product_params)
    @cart_product.customer_id = current_customer.id
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
