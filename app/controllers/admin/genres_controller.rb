class Admin::GenresController < ApplicationController

  before_action :move_to_signed_in

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
        #サインインしていないユーザーは管理者ログインページが表示される
        redirect_to new_admin_session_path
      end
    end

end
