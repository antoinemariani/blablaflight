class DashboardsController < ApplicationController
  def profile
    @user_flights = current_user.flights

    @user_bookings = current_user.bookings
    # Pundit
    authorize @user_flights
    authorize @user_bookings
  end

  def edit
  end
end
