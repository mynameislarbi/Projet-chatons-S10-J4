class OrdersController < ApplicationController
  def index
  end

  def destroy
  end

  def create
    @order = Order.new(item_id: params[:item_id], customer_id: current_user.id, achieved: false)
    if @order.save
      redirect_to new_charge_path
    else
      flash.now[:error] = "ERRORRR"
    end
  end

  def show
    
  end

  def update
  end

  def new
  end
end
