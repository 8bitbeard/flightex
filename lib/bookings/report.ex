defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Bookings.Booking

  def call(from_date, to_date) do
    bookings_list =
      convert_date(from_date, to_date)
      |> build_bookings_list()

    File.write("report.csv", bookings_list)

    {:ok, "Report generated successfully"}
  end

  def generate(filename \\ "report.csv") do
    bookings_list = build_bookings_list()

    File.write(filename, bookings_list)
  end

  defp build_bookings_list do
    BookingsAgent.list_all()
    |> Map.values()
    |> Enum.map(&booking_string(&1))
  end

  def build_bookings_list({from_date, to_date}) do
    BookingsAgent.list_all()
    |> Map.values()
    |> Enum.filter(fn booking -> check_date(booking.complete_date, from_date, to_date) end)
    |> Enum.map(&booking_string(&1))
  end

  defp convert_date(from_date, to_date) do
    {:ok, converted_from_date} = NaiveDateTime.from_iso8601(from_date <> " 00:00:00")
    {:ok, converted_to_date} = NaiveDateTime.from_iso8601(to_date <> " 23:59:59")

    {converted_from_date, converted_to_date}
  end

  defp check_date(date, from_date, to_date) do
    from_date <= date and date <= to_date
  end

  defp booking_string(%Booking{
         user_id: user_id,
         local_origin: local_origin,
         local_destination: local_destination,
         complete_date: complete_date
       }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
