class BookingsController < ApplicationController
  before_action :set_flight, only: %i[index show create new]

  def index
    @bookings = @flight.bookings
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @flight = Flight.find(params[:flight_id])
    @booking.user = current_user
    @booking.flight = @flight
    authorize @booking
    if @booking.save
      # diminuer la capacité du flight concerné
      @flight.capacity -= 1
      @flight.save
      redirect_to flight_path(@flight)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to profile_path, status: :see_other
  end

  private

  def set_flight
    @flight = Flight.find(params[:flight_id])
  end

  def booking_params
    params.permit(:flight_id)
  end
end
