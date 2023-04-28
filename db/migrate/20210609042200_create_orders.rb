class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.boolean :is_done
      t.boolean :is_confirmed
      t.integer :grade #, null: true
      t.integer :rating
      t.references :client, foreign_key: {to_table: :users}
      t.references :deliveryman, foreign_key: {to_table: :users}, null: true
      t.references :restaurant, foreign_key: {to_table: :restaurants}
      t.float :total_value, default: 0
      t.timestamps
    end
  end
end
