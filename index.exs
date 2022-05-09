_ = """
Elixir implementation of Nasa Ship Fuel Calculator
"""

defmodule FuelCalulator do
  def calculate(fsm, flights) do
    # [[launch: 9.807, land: 1.62], [launch: 1.62, land: 9.807]]
    travels = partition_flights(flights)

    res =
      Enum.map(travels, fn t ->
        calculate_fuel_weight(fsm, t)
      end)

    total_fuel_weight = Enum.sum(res)

    total_fuel_weight =
      total_fuel_weight
      |> Float.ceil(2)

    IO.puts("Weight of fuel: #{total_fuel_weight} \n")
  end

  defp partition_flights(flights) do
    Enum.chunk_every(flights, 2)
  end

  defp calculate_fuel_weight(fsm, flight_tuple) do
    launch = Enum.at(flight_tuple, 0)
    land = Enum.at(flight_tuple, 1)

    fw_launch = Launch.calculate(Enum.at(launch, 1), fsm)
    fw_land = Land.calculate(Enum.at(land, 1), fsm)

    fw_launch + fw_land
  end
end

defmodule Launch do
  def calculate(target, fsm) do
    cal_recursively(target, fsm, [])
  end

  defp cal_recursively(target, fsm, res) when fsm > 0 do
    fsm = fsm * target * 0.033 - 42

    unless fsm > 0 do
      cal_recursively(target, fsm, res)
    else
      res = res ++ [fsm]
      cal_recursively(target, fsm, res)
    end
  end

  defp cal_recursively(_target, fsm, res) when fsm < 0 do
    Enum.sum(res)
  end
end

defmodule Land do
  def calculate(target, fsm) do
    cal_recursively(target, fsm, [])
  end

  defp cal_recursively(target, fsm, res) when fsm > 0 do
    fsm = fsm * target * 0.042 - 33

    unless fsm > 0 do
      cal_recursively(target, fsm, res)
    else
      res = res ++ [fsm]
      cal_recursively(target, fsm, res)
    end
  end

  defp cal_recursively(_target, fsm, res) when fsm < 0 do
    Enum.sum(res)
  end
end

fsm = 28801
flights = [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]
FuelCalulator.calculate(fsm, flights)

fsm = 75432

flights = [
  [:launch, 9.807],
  [:land, 1.62],
  [:launch, 1.62],
  [:land, 3.711],
  [:launch, 3.711],
  [:land, 9.807]
]

FuelCalulator.calculate(fsm, flights)
