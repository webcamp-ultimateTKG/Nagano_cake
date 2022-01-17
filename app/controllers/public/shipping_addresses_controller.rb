class Public::ShippingAddressesController < ApplicationController
  #before_action :authenticate_user!

  def index
    @customer = current_customer
    @shipping_addresses = ShippingAddress.all
    @shipping_address = ShippingAddress.new
  end

  def create
    @customer = current_customer
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.customer_id = current_user.id
    if @shipping_address.save
      redirect_to shipping_addresses_path
    else
      render :index
    end
  end

  def edit
    @customer = current_customer
    @shipping_address = ShippingAddress.find(:id)
  end

  def update
    @shipping_address = ShippingAddress.find(:id)
    @shipping_address.customer_id = current_user.id
    if @shipping_address.save(shipping_address_params)
      redirect_to shipping_addresses_path
    else
      render :edit
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find(:id)
    @shipping_address.destroy
    redirect_to shipping_addresses_path
  end

  private

  def shipping_address_params
    params.require(:shipping_address).permit(:post_code, :address, :owner)
  end
end
