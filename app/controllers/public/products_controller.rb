class Public::ProductsController < ApplicationController


  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @products = Product.where(genre_id:@genre.id).page(params[:page]).per(6)
    else
      @products = Product.page(params[:page]).per(6)
    end
  end

  def show
    @product = Product.find(params[:id])
    @cart_product = CartProduct.new
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @products = Product.where(genre_id:@genre.id).page(params[:page]).per(6)
    else
      @products = Product.page(params[:page]).per(6)
    end
  end

  def search
    keyword = params[:keyword]
    @products = Product.search(keyword).page(params[:page]).per(6)
    @genres = Genre.all
  end

end
