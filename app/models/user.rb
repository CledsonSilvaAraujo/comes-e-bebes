class User < ApplicationRecord
  has_secure_password
  
  has_many :orders, foreign_key: :deliveryman_id, dependent: :destroy
  has_many :orders, foreign_key: :client_id, dependent: :destroy
  has_one :restaurant, foreign_key: :owner_id, dependent: :destroy

  enum role:{ 
    "anonymous": 0,
    "admin": 1,
    "owner": 2,
    "client": 3,
    "deliveryman": 4
  }

  before_create :generate_validation_token
  
  #Funções
  #Verificação das roles
  def admin
    return @user.role == 1 ? true : false
  end
  
  def owner
    return @user.role == 2 ? true : false
  end
  def client
    return @user.role == 3 ? true : false
  end
  
  def deliveryman
    return @user.role == 4 ? true : false
  end

  def generate_validation_token
    byebug
    self.validate_token = generate_random_token
    self.validate_token_expiry_at = Time.now.utc + 120.minutes
    self.save
  end

  def validate_user?(token)
    if validate_token_expiry_at > Time.now
      self.is_valid = true
      #self.role = 1
      self.validate_token = nil
      return true if self.save
    else 
      return false
    end
  end

  def reset_password_complete?(password, password_confirmation)
    self.password = password
    self.password_confirmation = password_confirmation
    self.validate_token = nil
    return true if self.save
  end

  private  
    def generate_random_token
      SecureRandom.alphanumeric(15)
    end

  # Users validations
  validates :name, :email, :birthdate, :phone, :password, :cpf, :address, :role, :funds, :cnh, presence:true
  validates :email, :cpf, :cnh,  uniqueness:true

  #Acho que precisa:
  validates :password, :password_confirmation, length: {minimum: 6}, if: :password
  validates :phone, length: {is: 11}, numericality: {only_integer:true}

end
