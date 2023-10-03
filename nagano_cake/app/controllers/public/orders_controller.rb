class Public::OrdersController < ApplicationController

  def index
    @orders = current_customer.orders.all
    @customer = current_customer
  end


  def new
    @order = Order.new
    @customer = current_customer
    @addresses = current_customer.addresses
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new(order_id: @order.id)
        order_detail.price = cart_item.item.price
        order_detail.quantity = cart_item.amount
        order_detail.item_id = cart_item.item_id
        order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to complete_orders_path
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @customer = current_customer
  end

  def confirmation
    @cart_items = current_customer.cart_items
    @customer = current_customer
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.payment_method = params[:order][:payment_method]

    if params[:order][:address_option] == "0"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      @addresses = Address.find(params[:order][:id])
      @order.postcode = @addresses.postcode
      @order.address = @addresses.address
      @order.name = @addresses.name
    elsif params[:order][:address_option] == "2"
      @addresess = Address.new(addresses_params)
      @addresess.addrese = params[:order][:addrese]
      @addresess.name = params[:order][:name]
      @addresess.postcode = params[:order][:postcode]
      @addresess.customer_id = current_customer.id
      if @addresess.save
      @order.postcode = @addresess.postcode
      @order.name = @addresess.name
      @order.addrese = @addresess.address
      else
       render 'new'
      end
    end
  end

  def complete
    @customer = current_customer
  end

    private

  def order_params
    params.require(:order).permit(:payment_method, :postcode, :address, :name, :postage, :payment_amount, :status)
  end

  def addresses_params
    params.require(:addresses).permit(:customer_id, :postcode, :address, :name, :address_id)
  end
end
