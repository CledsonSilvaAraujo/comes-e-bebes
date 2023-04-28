class OrderDishController < ApplicationController
  before_action :set_order_dish, :set_order_dishes, only: [:add_item, :remove_item]
  
  def index
    @orderdishes = OrderDish.all 
    render json: @orderdishes
  end

  def show
    # byebug
    render json: @orderdishes
  end

  def add_item
    # byebug
    if @orderdish.nil?
      # byebug
      @orderdish = OrderDish.new(order_dish_params)
    end
    @orderdish.quantity += 1
    # byebug
    if @orderdish.save
      render json: @orderdishes
    else
      render json: @orderdish.error
    end
  end

  def remove_item
    if @orderdish.nil?
      return render json: @orderdishes
    end
    @orderdish.quantity -= 1
    if @orderdish.quantity > 0
      if @orderdish.save
        render json: @orderdishes
      else
        render json: @orderdish.error
      end
    else
      @orderdish.destroy
      render json: @orderdishes
    end
  end

  def set_order_dish
    @orderdish = OrderDish.find_by(
      order_id: order_dish_params[:order_id], 
      dish_id: order_dish_params[:dish_id])
    
  end

  def set_order_dishes
    @orderdishes = OrderDish.where(
      order_id: order_dish_params[:order_id])
  end

  def order_dish_params
    params.require(:order_dish).permit(
      :order_id, 
      :dish_id, 
      :quantity,
      :partial_value 
      )
  end
end
