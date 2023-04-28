class Restaurant < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :owner, class_name: "User"
  has_many :dishes, dependent: :destroy
  has_many :orders, dependent: :destroy
 
  # restaurants validations
  validates :name, :image, :foodType, :openingHour, :address, :cnpj, :rating, :most_selled, :total_sales, :total_loyal_costumers, :owner_id, presence:true

  validates :owner_id, :cnpj, uniqueness:true

end

  