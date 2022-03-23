class ChargesController < ApplicationController
    def new
        @amount = calculate_order_amount
    end
    
    def create
        @orders = Array.new
        if (params[:from_cart] == "false")
            @order = Order.create!(achieved: false, item_id: params.permit(:item_id), customer_id: current_user.id)
            @amount = Item.find(params[:item_id].to_i).price
        elsif (params[:from_cart] == "true")
            current_cart.each do |cartItem|
                @orders << Order.create!(achieved: false, item_id: cartItem.item_id, customer_id: current_user.id)
            end
            @amount = cart_total
        end

        customer = Stripe::Customer.create({
            email: params[:stripeEmail],
            source: params[:stripeToken],
        })
    
        charge = Stripe::Charge.create({
            customer: customer.id,
            amount: @amount,
            description: 'Rails Stripe customer',
            currency: 'usd',
        })
        @orders.each do |order|
            puts order.id
            order.achieved = true
            order.save
        end
        if (params[:from_cart] == "true")
            destroy_cart
        end
        rescue Stripe::CardError => e
            flash[:error] = e.message
            redirect_to new_charge_path
    end
end
