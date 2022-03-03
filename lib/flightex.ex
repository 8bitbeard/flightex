defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBookings
  alias Flightex.Users.Agent, as: UsersAgent

  def start_agents do
    UsersAgent.start_link(%{})
    BookingsAgent.start_link(%{})
  end

  defdelegate create_or_update_booking(params), to: CreateOrUpdateBookings, as: :call
end
