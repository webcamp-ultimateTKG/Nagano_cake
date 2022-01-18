class Admin::ProductsController < ApplicationController
  before_action :move_to_signed_in

  def index
    @products = Product.page(params[:page]).reverse_order
  end

  def show
    @product = Product.find(params[:id])
  end

  private
    def move_to_signed_in
      unless admin_signed_in?
        #管理者ログインしていない場合はtopページに行く
        redirect_to root_path
      end
    end
end
