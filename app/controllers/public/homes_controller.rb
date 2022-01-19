class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @products = Product.where(genre_id:@genre.id).page(params[:page]).per(6)
    else
      @products = Product.page(params[:page]).per(6)
    end
  end

  def about
  end
end
