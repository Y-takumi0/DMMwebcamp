class Public::AddressesController < ApplicationController

  def index
    @customer = current_customer
    @addresses = Address.all
    @address = Address.new
  end

  def edit
    @customer = current_customer
    @address = Address.find(params[:id])
    unless @customer.id == current_customer.id
      redirect_to addresses_path
    end
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      @addresses = Address.all
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :address, :postcode)
  end
end
