class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:edit, :update, :destroy, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was sucessfully created'
    else
      render :new
    end
  end

  def show
    @reviews = Review.where("restaurant_id = ?", params[:id])
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path
    else
      render :edit
    end
  end

  def destroy
    @restaurant.delete
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit( :name, :address, :category, :phone_number )
    
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
