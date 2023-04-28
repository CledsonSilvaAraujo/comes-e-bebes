class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :foodType, :openingHour, :address, :cnpj, :rating,  :owner_id
  belongs_to :owner, class_name: "User"
  has_many :dishes
  has_many :orders
end
