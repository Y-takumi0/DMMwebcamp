class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
    @item = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end


  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品情報を更新しました。"
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :genre_id, :introduction, :price, :is_sale, :image)
  end
end
