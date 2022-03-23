module CartsHelper
    def current_cart
        @current_cart = []
        @cart_items = CartItem.all
        @cart_items.each do |item|
            if item.user_id == current_user.id
                @current_cart << item
            end
        end
    end

    def cart_total
        @price = 0
        current_cart.each do |cart_item|
            @price += Item.find(cart_item.item_id).price
        end
        return @price
    end

    def already_in_cart(new_cart_item)
        @cart_items = current_cart
        @cart_items.each do |item|
            if item.item_id == new_cart_item.item_id
                return true
            end
        end
        return false
    end

    def destroy_cart
        @cart_items = CartItem.all
        @cart_items.each do |item|
            if item.user_id == current_user.id
                item.destroy
            end
        end
    end
end