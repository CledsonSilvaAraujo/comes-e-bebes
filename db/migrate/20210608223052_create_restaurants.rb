class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :foodType
      t.string :openingHour
      t.string :address
      t.string :cnpj
      t.float :rating
      t.integer :most_selled
      t.integer :total_sales
      t.integer :total_loyal_costumers
      t.references :owner, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
