class Order < ApplicationRecord

  has_many :order_dishes, dependent: :destroy
  belongs_to :client, class_name:"User"
  belongs_to :deliveryman, class_name:"User", optional: true
  belongs_to :restaurant


  # orders validations
  validates :dish_id, :client_id, :restaurant_id, :is_confirmed, :is_done, :rating, :grade, :deliveryman_id, presence:true 
  validates :dish_id, :client_id, :restaurant_id, :deliveryman_id, uniqueness:true

end
