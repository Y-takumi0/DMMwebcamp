class Public::ItemsController < ApplicationController

  def index
    @customer = current_customer
    @genres = Genre.where(is_sale: true)
    if params[:genre_id]
		  @genre = Genre.find(params[:genre_id])
		  @items = @genre.items.where(is_sale: true).page(params[:page]).reverse_order
    else
      @items = Item.where(is_sale: true)
    end
  end

  def show
    @item = Item.find(params[:id])
    @customer = current_customer
    @genres = Genre.where(is_active: true)
    @cart_item = CartItem.new
  end

  	private
	def params_product
		parmas.require(:item).permit(:image ,:name )
	end

end
