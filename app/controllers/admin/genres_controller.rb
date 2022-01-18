class Admin::GenresController < ApplicationController

  before_action :move_to_signed_in
  before_action :if_not_admin

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end


  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path
  end

  private
    def genre_params
      params.require(:genre).permit(:name)
    end

    def move_to_signed_in
      unless admin_signed_in?
        #管理者ログインしていない場合はtopページに行く
        redirect_to root_path
      end
    end

end


