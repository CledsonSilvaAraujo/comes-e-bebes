class CreateDishes < ActiveRecord::Migration[6.1]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :description
      t.float :value
      t.integer :portionSize
      t.integer :quantity, default: 0
      t.references :restaurant, foreign_key: {to_table: :restaurants} , null: false
      t.timestamps
    end
  end
end
