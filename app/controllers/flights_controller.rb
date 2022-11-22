class FlightsController < ApplicationController
  before_action :set_flight, only: %i[show edit update destroy]

  def index
    @flights = policy_scope(Flight)
    @flights = Flight.all
  end

  def show; end
  
  def new
    @flight = Flight.new
    authorize @flight # Pundit
  end

  def create
    @flight = Flight.new(flight_params)
    @flight.user = current_user
    authorize @flight # Pundit
    @flight.save!
    redirect_to flight_path(@flight)
  end

  def edit; end

  def update
    @flight.update!(flight_params)
    redirect_to flight_path(@flight)
  end

  def destroy
    @flight.destroy!
    redirect_to flights_path, status: :see_other
  end

  private

  def flight_params
    params.require(:flight).permit(:capacity, :departure, :arrival, :date, :price)
  end

  def set_flight
    @flight = Flight.find(params[:id])
    authorize @flight
  end
end
