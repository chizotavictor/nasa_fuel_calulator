from typing import Tuple, List

"""
    Class: NasaFuelCalulator
    fsm: Flight Ship Mass
    flights: Array of Flight Tuple
"""


class NasaFuelCalulator():

    fsm = 0.00
    flights = []

    def __init__(self, fsm: int, flights: List[Tuple[float, float]] = []):
        self.fsm = fsm
        self.flights = flights

    def calculate_fuel(self):
        total_weight = 0

        for (launch, land) in self.flights:
            fuel_weight_for_launch = self.calculate_fuel_for_lauch(launch)
            fuel_weight_for_land = self.calculate_fuel_for_land(land)

            sm = fuel_weight_for_land + fuel_weight_for_launch
            total_weight = total_weight + sm

        total_weight = total_weight
        return round(total_weight, 2)

    def calculate_fuel_for_lauch(self, target):
        weights = []
        while True:
            if len(weights) == 0:
                res = (self.fsm * target * 0.042) - 33
                weights.append(res)
            else:
                res = (weights[len(
                    weights) - 1] * target * 0.042) - 33
                if res == 0 or res < 0:
                    break
                else:
                    weights.append(res)

        ans = sum(weights)
        return ans

    def calculate_fuel_for_land(self, target):
        weights = []
        while True:
            if len(weights) == 0:
                res = (self.fsm * target * 0.033) - 42
                weights.append(res)
            else:
                res = (weights[len(weights) - 1] * target * 0.033) - 42
                if res == 0 or res < 0:
                    break
                else:
                    weights.append(res)

        ans = sum(weights)
        return ans


# Apollo 11
fsm = 28801
travel = [(9.807, 1.62), (1.62, 9.807)]
result = NasaFuelCalulator(fsm, travel)
print("Weight of fuel: " + str(result.calculate_fuel()) + "\n")

# Mission on Mars
fsm = 14606
travel = [(9.807, 3.711), (3.711, 9.807)]
result = NasaFuelCalulator(fsm, travel)
print("Weight of fuel: " + str(result.calculate_fuel()) + "\n")

# Passenger ship
fsm = 75432
travel = [(9.807, 1.62), (1.62, 3.711), (3.711, 9.807)]
result = NasaFuelCalulator(fsm, travel)
print("Weight of fuel: " + str(result.calculate_fuel()) + "\n")
