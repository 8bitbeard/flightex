defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(complete_date, local_origin, local_destination, user_id) when is_binary(user_id) do
    {:ok,
     %__MODULE__{
       complete_date: complete_date,
       local_origin: local_origin,
       local_destination: local_destination,
       user_id: user_id,
       id: UUID.uuid4()
     }}
  end

  def build(_complete_date, _local_origin, _locla_destination, _user_id),
    do: {:error, "User id must be a valid UUID"}
end
