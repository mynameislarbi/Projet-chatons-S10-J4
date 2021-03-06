class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.belongs_to :item, index: true
      t.belongs_to :user, index: true
      t.integer :quantity
      t.integer :price
      
      t.timestamps
    end
  end
end
