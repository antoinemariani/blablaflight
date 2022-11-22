class BookingsController < ApplicationController
  before_action :set_flight, only: %i[index show create new]

  def index
    @bookings = @flight.bookings
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.flight = @flight
    if @booking.save
      redirect_to flight_path(@flight)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to flight_path(@booking.flight), status: :see_other
  end

  private

  def set_flight
    @flight = Flight.find(params[:flight_id])
  end

  def booking_params
    params.permit(:flight_id)
  end
end