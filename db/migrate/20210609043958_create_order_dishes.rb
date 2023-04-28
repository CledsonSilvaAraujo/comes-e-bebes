class CreateOrderDishes < ActiveRecord::Migration[6.1]
  def change
    create_table :order_dishes do |t|
      t.references :order, null: false, foreign_key: {to_table: :orders}
      t.references :dish, null: false, foreign_key: {to_table: :dishes}
      t.integer :quantity, default: 0
      t.float :partial_value, default: 0
      t.timestamps
    end
  end
end
