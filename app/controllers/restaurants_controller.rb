  class RestaurantsController < ApplicationController
  # def create
  #   autorizacao usando brcrypt
  # end
  before_action :set_restaurant, only: [:show, :update, :destroy, :rate, :add_logo]
  load_and_authorize_resource
  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      render json: @restaurant, status: 201
    else
      render json: @restaurant.errors, status: 422
    end
  end

  def index
    @restaurants = Restaurant.all
    render json: @restaurants
  end


  
  def show
    render json: @restaurant
  end
  
  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
    else
      render json: @restaurant.errors, status: 422
    end
  end
  
  def destroy
    @restaurant.destroy
  end
  
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end 
  
  def restaurant_params
    params.require(:restaurant).permit(
      :name,
      :foodType,
      :openingHour,
      :address, 
      :cnpj,
      :owner_id 
  )

  end
  def results
    
    total_value = Order.where(restaurant_id: params[:id]).sum("total_value")
    average_rating = Order.where(restaurant_id: params[:id]).where.not(rating: nil).average("rating")
    total_fidelized_clients = 0
    orders = Order.where(restaurant_id: params[:id]).group(:client_id).count
    
    orders.each_pair do |k,v|
      if v >= 3
        total_fidelized_clients += 1
      end
    end
    
    dish_sales = Order.where(restaurant_id: params[:id]).joins(:order_dishes).group(:dish_id).count
    most_selled_dishes = Hash[dish_sales.sort_by{|k, v| v}.reverse]
    array_top_3 = []
    for i in dishes.values
      array_top_3.push(i)
    end
    top_ranking = {
      first_dish: array_top_3[0],
      second_dish: array_top_3[1],
      third_dish: array_top_3[2]
    }
    result = {
      total_value: total_value,
      average_rating: average_rating,
      total_fidelized_clients: total_fidelized_clients,
      top_ranking: top_ranking
    }
    
    render json: result

    
   

    ##incoerente
    # #considerando que todas as compras realizadas dao rating se não houver
    # # rating ativo do cliente, ou seja, ele avaliar
    # # no final da compra o rating sera 5 estrelas
    # if @restaurant.rating == nil
    #   # puts "oi"
    #   # puts rate_params[:rating]
    #   total_ratings = rate_params[:rating]
    # else
    #   # @restaurant.total_sales  = 2
    #   # puts "tchau"
    #   # puts @restaurant.rating
    #   # puts @restaurant.total_sales
    #   total_ratings = @restaurant.rating * @restaurant.total_sales + rate_params[:rating]
    # end
    # #sera que eu deveria adicionar 1 ao @restaurant.total_sales, pois ai eu ja contaria que ao finalizar a conta já houve o raiting
    # ###########ao final da order o total sales tem que ser incrementado em um para aqui fazer sentido
    # # @restaurant.rating = total_ratings/(@restaurant.total_sales)
    # @restaurant.rating = total_ratings/ @restaurant.total_sales 
    # if @restaurant.save
    #   render json: @restaurant.rating, status: 200
    # else
    #   render json:{error: "Não foi possivel realizar avaliacao do restaurante"}, status: 400
    # end

  end

  def show
    render json: @restaurant
  end
  
  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
    else
      render json: @restaurant.errors, status: 422
    end
  end
  
  def destroy
    if @restaurant.destroy
      render json: {"Sucesso":"Deletado"}
    else
      render json: {error: "Não é permitido deletar esse restaurante"}, status: 401
    end
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end 
  #talvez seja melhor alterar para current_user.image e nao esquecer de retirar o add_logo do :before_action
  def add_logo
    @restaurant.image = params[:image]
    if @restaurant.save
      render json: @restaurant
    else
      render json: @restaurant.errors, status: 422
    end
  end

  

  def rate_params
    params.require(:restaurant).permit(:rating
  )
  end
  def better_rated_restaurant
    restaurant = Restaurant.where(rating: Restaurant.all.maximum(:rating))[0]
    render json: restaurant
  end

end


