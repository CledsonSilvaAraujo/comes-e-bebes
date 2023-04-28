class OrderDishSerializer < ActiveModel::Serializer
  attributes :id, :order_id, :dish_id, :quantity, :partial_value
  belongs_to :order
  belongs_to :dish  
end
