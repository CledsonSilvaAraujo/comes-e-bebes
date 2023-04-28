class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate, :cpf, :address, :funds, :cnh, :vehicle, :role, :validate_token, :validate_token_expiry_at, :is_valid
  has_many :orders, foreign_key: :deliveryman_id
  has_many :orders, foreign_key: :client_id
  has_one :restaurant, foreign_key: :owner_id
end