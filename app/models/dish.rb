
  mount_uploader :image, ImageUploader
  has_many :order_dish, dependent: :destroy
  belongs_to :restaurant

  enum portionSize: { 
   "Pequena": 1,
   "Média": 2,
   "Grande": 3
  }
  # Dishes validations
  validates :name, :description, :value, :portionSize, :quantity, presence:true
  
end
