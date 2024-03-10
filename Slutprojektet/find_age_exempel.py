def find_age(self, beginning_of_age, end_of_age):
    positions = []

    for i, passenger in enumerate(self.passengers):
        if beginning_of_age <= passenger["age"] <= end_of_age:
            positions.append(i + 1)

    

    if positions:
        print(f"Passagerare med ålder mellan {beginning_of_age} och {end_of_age} finns på positionerna: {', '.join(map(str, positions))}")
    else:
        print(f"Inga passagerare med ålder mellan {beginning_of_age} och {end_of_age} hittades.")
