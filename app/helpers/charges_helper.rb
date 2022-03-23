module ChargesHelper
    def calculate_order_amount
        clear_orders
        @amount = 0
        @orders = Order.all
        @orders.each do |order|
            if order.customer_id == current_user.id && !order.achieved
                @amount += Item.find(order.item_id).price
            end
        end
        return @amount
    end

    def clear_orders
        @orders = Order.all
        @orders.each do |order|
            if !order.achieved
                d = false
                Item.all.each do |item|
                    if item.id == order.id
                        d = true
                    end
                end
                order.destroy if d
            end
        end
    end
end
