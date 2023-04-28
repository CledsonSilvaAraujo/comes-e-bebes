class DishesController < ApplicationController
  before_action :set_dish, only: [:show, :destroy, :update, :change_quantity, :add_dish_photo]
  load_and_authorize_resource
  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      render json: @dish, status: 201
    else
      render json: @dish.errors, status: 422
    end
  end

  def index
    @dishes = Dish.all
    render json: @dishes
  end

  def show
    render json: @dish
  end

  def is_greater_or_equal_to_zero? params
    if params["quantity"] >= 0
      return true
    else
      return false
    end
  end

  def change_quantity
    quantity = params.require(:dish).permit(
      :quantity
    )
    if is_greater_or_equal_to_zero? quantity
      @dish.quantity = quantity["quantity"]
      if @dish.save
        render json: {status: "Tudo certo, quantidade alterada"}, status: 200
      else
        render json: {error: "Não é possivel alterar a quantidade"}, status: 400
      end
    else
      render json: {error:"Não é possivel alterar o a quantidade para um valor menor que zero"}, status: 406
    end

  end

  def update
    if @dish.update(dish_params)
      render json: @dish
    else
      render json: @dish.errors, status: 422
    end
  end

  def destroy 
    @dish.destroy
  end

  def set_dish
    @dish = Dish.find(params[:id])
  end
# Lembrar de identificar a quantidade como 0
  def dish_params
    params.require(:dish).permit(:name,
      :description,
      :value,
      :portionSize,
      :quantity,
      :restaurant_id)
  end

  def add_dish_photo
    @dish.image = params[:image]
    if @dish.save
      render json: @dish
    else
      render json: @dish.errors, status: 422
    end
  end
  
end



