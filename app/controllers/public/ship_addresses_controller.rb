class Public::ShipAddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @ship_addresses = ShipAddress.where(customer_id: current_customer.id)
    @ship_address = ShipAddress.new
  end

  def create
    @ship_address = ShipAddress.new(ship_address_params)
    @ship_address.customer_id = current_customer.id
    if @ship_address.save
      redirect_to ship_addresses_path
    else
      render :index
    end
  end

  def edit
    @ship_address = ShipAddress.find(params[:id])
  end

  def update
    @ship_address = ShipAddress.find(params[:id])
    @ship_address.customer_id = current_customer.id
    if @ship_address.update(ship_address_params)
      redirect_to ship_addresses_path
    else
      render :edit
    end
  end

  def destroy
    @ship_address = ShipAddress.find(params[:id])
    @ship_address.destroy
    redirect_to ship_addresses_path
  end

  private

  def ship_address_params
    params.require(:ship_address).permit(:post_code, :address, :owner)
  end
end
