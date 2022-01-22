class Public::ProductsController < ApplicationController


  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @products = Product.where(genre_id:@genre.id).page(params[:page]).per(6).order(created_at: :desc)
    else
      @products = Product.page(params[:page]).per(6).order(created_at: :desc)
    end
  end

  def show
    @product = Product.find(params[:id])
    @cart_product = CartProduct.new
    @genres = Genre.all
  end

  def search
    keyword = params[:keyword]
    if keyword == ""
      redirect_to products_path
    else
      @products = Product.search(keyword).page(params[:page]).per(6)
      @genres = Genre.all
    end
  end

end
