class CartsController < ApplicationController
  include CartsHelper
  before_action :authenticate_user

  def index
    @cart = current_cart
  end

  def create
    :authenticate_user
    @cart_item = CartItem.new(permit_params)
    unless (already_in_cart(@cart_item))
      if @cart_item.save
        respond_to do |format|
          format.js { }
        end
      else 
        flash.now[:error] = puts @cart_item.errors.messages
        render 'chat'
      end
    end
  end

  def new
  end

  def update
  end

  def show
    @cart = current_cart
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js { }
    end
  end

  def destroy
    CartItem.find(params[:id].to_i).destroy
    @cart = current_cart
    respond_to do |format|
      format.html { redirect_to carts_path }
      format.js { }
    end
  end

  private

  def find_price
    return Item.find(params[:item_id].to_i).price
  end

  def permit_params
    params[:price] = find_price
    params[:user_id] = current_user.id
    params.permit(:item_id, :user_id, :quantity, :price)
  end

  def authenticate_user
    unless (user_signed_in?)
      redirect_to user_session_path
    end
  end

  def permit_params
    params[:price] = find_price
    params[:user_id] = current_user.id
    params.permit(:item_id, :user_id, :quantity, :price)
  end

end
