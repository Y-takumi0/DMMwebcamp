class Public::AddressesController < ApplicationController

  def index
    @customer = current_customer
    @addresses = Address.all
    @address = Address.new
  end

  def edit
    @customer = current_customer
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to address_path
    else
      @addresses = Address.all
      render :index
    end
  end

  def update
    if @address.update(address_params)
      redirect_to adsress_path
    else
      render :edit
    end
  end

end
