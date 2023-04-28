class OrderDish < ApplicationRecord
  belongs_to :order
  belongs_to :dish  
  # #botei isso, Assinado: Cledson
  # belongs_to :restaurant

  # orders_dishes validations
  validates :order_id, :dish_id, :quantity, presence:true

  validates :owner_id, :dish_id, uniqueness:true

end
