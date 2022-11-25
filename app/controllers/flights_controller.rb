class FlightsController < ApplicationController
  before_action :set_flight, only: %i[show edit update destroy]

  def index
    @flights = policy_scope(Flight)
    @booking = Booking.new
    if params[:query].present?
      @flights = Flight.search_by_departure_and_arrival(params[:query])
    else
      @flights = Flight.all
    end
  end

  def show
    @booking = Booking.new
    authorize @flight
    # checker si user a déjà book le flight
    @already_book = false
    @flight.bookings.each do |booking|
      @already_book = true if booking.user_id == current_user.id
    end
    @markers =
      {
        lat: @flight.latitude,
        lng: @flight.longitude,
        info_window: render_to_string(partial: "info_window", locals: { flight: @flight })
      }
  end

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
    params.require(:flight).permit(:capacity, :departure, :arrival, :date, :price, :photo)
  end

  def set_flight
    @flight = Flight.find(params[:id])
    authorize @flight
  end
end
