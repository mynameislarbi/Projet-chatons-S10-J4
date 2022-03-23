class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(permit_params)
    @item.picture.attach(params[:cat_picture])
    if @item.save
      redirect_to items_path
    else
      flash.now[:errors] = "There were those errors : "
      render new_item_path
    end
  end

  def destroy
    Item.find(params[:id]).destroy
  end

  def update
    Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  private

  def permit_params
    params.permit(:name, :price)
  end
end
