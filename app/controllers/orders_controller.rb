class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy, :update, :conclude_order]
  load_and_authorize_resource

  def evaluate_order
    # armazena nota(1 ate 5), o restaurante e o prato 
    dish_grade_restaurant = {rate: grade, dish: dish_id, restaurant: restaurant_id}
  end

  def is_confirmed # 
    #boolean
    if @order.is_confirmed?
      self.show
      return "Confirmed!"
    else
      return "Not confirmed!"
    end
  end

  def is_done
    #boolean
    @orders = @orders.where(is_done: true).all   
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order, status: 201
    else
      render json: @order.errors, status: 422
    end
  end

  def index
    @orders = @orders.where(is_done: false).all #Order.where(is_done: false).all
    render json: @orders
  end

  def show
    render json: @order
  end

  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: 422
    end
  end

  def create_cart
    byebug
  end

  def conclude_order
    @order.is_done = true
    if @order.save
      render json: @order
    else
      render json: @order.errors, status: 422
    end
  end

  def destroy
    @order.destroy 
  end

  def set_orders
    @order = Order.find(params[:id])
  end 


  # def orders_params #creates new orders
  #   params.require(:orders).permit(
  #     :dish_id, 

  def order_params #creates new orders
    params.require(:order).permit(
      :dish_id:, 
      :client_id, 
      :restaurant_id, 
      :deliveryman_id,
      :grade,
      :is_confirmed)
  end

  def set_order
    @order = Order.find(params[:id])
  end 

  
  def conclude_params
    params.require(:order).permit(
      :is_done)
    end
    
  #alterei isso aqui. Assinado: Cledson
  def is_it_an_integer? num
    if num.class == Integer
      return true
    end
    return false
  end
  def is_it_between_1_and_5? num
    if (num >=1) && (num <=5)
      return true
    end
    return false
  end
  
  #Alterei aqui, cledson
  def rate_an_order
    params.require(:user).permit(
      :order_id,
      :rate
    )
    # client_id = params[:user][:client_id]
    rated_value = params[:user][:rate]
    order_id = params[:user][:order_id]

    # if client_id == nil
    #   render json: {error: "O cliente tem que existir"}
    # end
    # if rated_value == nil
    #   rated_value = 5
    # end
    
    if (is_it_an_integer? rated_value) && (is_it_between_1_and_5? rated_value)

      order = Order.find(order_id)
      order.update(rating: rated_value)
      if(order.save)
        render json: order
      else
        render json: {error: "Não foi possivel avaliar o pedido"}
      end
    else
      render json: {error: "Ou o valor passado para a avaliação não é um interior (Integer) ou ele não esta entre 1 e 5"}
    end
    
    # if (is_it_an_integer? rated_value) && (is_it_between_1_and_5? rated_value)
    
    #   restaurant = Restaurant.find(order_id)
    #   if restaurant[:rating] == nil
    #     restaurant.update(rating: 0)
    #   end
    #   if restaurant[:total_sales] == nil
    #     restaurant.update(total_sales: 1)
    #   end
    #   average_rating = (restaurant[:rating]*restaurant[:total_sales] + rated_value)/restaurant[:total_sales]
    #   restaurant.update(rating: average_rating)
    #   if(restaurant.save)
    #     render json: restaurant
    #   else
    #     render json: {error: "Não foi possivel avaliar o restaurant"}
    #   end
    # else
    #   render json: {error: "Ou o valor passado para a avaliação não é um interior (Integer) ou ele não esta entre 1 e 5"}
    # end
  end
  
  def order_params #creates new orders
    params.require(:orders).permit(
      :dish_id, 
      :client_id, 
      :restaurant_id, 
      :deliveryman_id,
      :grade,
      :is_confirmed,
      :is_done)
  end
  
end
