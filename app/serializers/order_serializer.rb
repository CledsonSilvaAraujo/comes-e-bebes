class OrderSerializer < ActiveModel::Serializer
   attributes :id, :is_done, :is_confirmed, :client_id, :deliveryman_id, :restaurant_id, :total_value
   has_many :order_dishes
    belongs_to :restaurant
    belongs_to :client, class_name:"User"
    belongs_to :deliveryman, class_name:"User"
end
