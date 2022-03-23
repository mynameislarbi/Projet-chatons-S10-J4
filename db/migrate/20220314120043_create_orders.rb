class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.boolean :achieved
      t.belongs_to :item, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
