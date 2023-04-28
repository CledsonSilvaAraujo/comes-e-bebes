class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :birthdate
      t.string :phone
      t.string :password_digest
      t.string :cpf
      t.string :address
      t.integer :role, default: 0
      t.boolean :is_valid, default: false
      t.string :validate_token
      t.datetime :validate_token_expiry_at
      t.float :funds
      t.string :cnh
      t.string :vehicle
      t.timestamps
    end
  end
end
