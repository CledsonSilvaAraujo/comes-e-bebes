class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :client_funds, :last_five_orders]
  load_and_authorize_resource
  

  def index
    #@users = User.select(:id,:name, :cpf, :email, :role, :birthdate, :address).all
    @users = User.all
		render json: @users
  end

  def show
    render json: @user	
  end

  def update
    if @user.update(user_params)
			render json: @user
		else
      render json: {error: "Não é possível cadastrar com esse papel"}, status: 401
    end
  end

  def destroy
    @user.destroy	
  end

  def index_deliverymen 
    @users = User.where(role: "deliveryman", is_valid: false).all
		render json: @users
  end

  def admit_deliveryman
    if @user.role == "deliveryman" && @user.update(is_valid: true)
      render json: @user
    else
      render json: {error: "Papel inválido"}, status: 401
    end
  end

  def deny_deliveryman 
    if @user.role == "deliveryman" && @user.update(is_valid: false)
      #tem que mandar o email ainda
      #@user.destroy tá dando errado
      render json: @user
    else
      render json: {error: "Papel inválido"}, status: 401
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
			:name, 
			:email, 
			:birthdate, 
			:address, 
			:phone, 
      :role,
      :cpf, 
      :is_valid, 
      :funds
      )
  end


  
  #FALTA CRIAR AS ROTAS cledson e last_five_orders so pode ser visto por Clientes

  def last_five_orders
    render json: Order.where(client_id: @user.id).limit(5).offset(Order.where(client_id: @user.id).length-5)
  end
  def user_funds
    render json: @user.funds 
  end
  def finishing_order
    user_id = @user.id
    last_orders = Order.where(client_id: @user.id).last
    OrderDish.where(order_id: last_orders.id).find(11).quantity * Dish.find( OrderDish.where(order_id: last_orders.id).find(11).dish_id).value
  end
  
  def changing_order
    #precisa da lista de todos os itens que estao naquele momento na ordem
    params.require(:user).permit(:order_dish_list)
    order_dishes = params.order_dish_list
    total_value = 0
    order_dishes.each do |order_Dish|
      total_value += order_Dish.quantity * Dish.find(order_Dish.dish_id).value
    end
    total_value
   
  end

  
end
