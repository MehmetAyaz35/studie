class Buss:
    def __init__(self, passengers=None):
        # If no passengers are provided, create an empty dictionary
        if passengers is not None:   # The "is not None" condition checks if any value other than None is passed.
            self.passengers = passengers
        else:
            self.passengers = {}
        self.number_of_passengers = len(self.passengers)

    def run(self):
        print("Välkommen till Buss-simulatorn")
        while True:
            choice = input("Välj en handling:\n1. Lägg till passagerare\n2. Visa passagerare\n3. Beräkna total ålder\n4. Beräkna genomsnittliga åldern\n5. Ta fram passagerare med högst ålder\n6. Visa alla positioner med passagerare med en viss ålder\n7. Sortera bussen efter ålder\n8. Skriv ut vilka positioner som har manliga respektive kvinnliga passagerare\n9. Hur passagerares reagerar om man petar på dom\n10. Passagerare stiger av\n0. Avsluta\nVal: ")

            if choice == "1":
                try:                                                       #Since the try block raises an error, the except block will be executed.Without the try block, the program will crash and raise an error:                 
                    seat_number = int(input("Ange platsnummer (1-25): "))
                    self.add_passenger(seat_number)
                except ValueError:
                    print("Ogiltigt val. Ange ett numeriskt platsnummer(1-25).")
                except KeyError as e:   # block raises
                    print(f"Error: {e} ")
            elif choice == "2":
                self.print_buss()
            elif choice == "3":
                self.calc_total_age()
            elif choice == "4":
                self.calc_average_age()
            elif choice == "5":
                self.max_age()
            elif choice == "6":
                beginning_of_age = int(input("Ange starten av åldersintervallet: "))
                end_of_age = int(input("Ange slutet av åldersintervallet: "))
                self.find_age(beginning_of_age, end_of_age)
            elif choice == "7":
                self.sort_buss()
            elif choice == "8":
                self.print_sex()
            elif choice == "9":
                self.poke()
            elif choice == "10":
                self.getting_off()
            elif choice == "0":
                print("Avslutar Buss-simulatorn")
                break
            else:
                print("Ogiltigt val. Försök igen.")

    def add_passenger(self, seat_number):
        if 1 <= seat_number <= 25:
            if seat_number in self.passengers:
                raise KeyError("Denna plats är redan upptagen. Välj ett annat säte.")

            passenger_name = input("Ange passagerarens namn: ")
            
            while True:
                try:
                    passenger_age = int(input("Ange passagerarens ålder (0-130): "))
                    if 0 <= passenger_age <= 130:
                        break
                    else:
                        print("Ogiltig ålder. Ange ålder mellan 0 och 130.")
                except ValueError:
                    print("Ogiltig inmatning. Ange ett numeriskt värde för ålder.")
            
            while True:
                passenger_sex = input("Ange passagerarens kön (m/f): ")
                if passenger_sex.lower() in ['m', 'f']:
                    break
                else:
                    print("Ogiltigt kön. Ange antingen 'm' för manlig eller 'f' för kvinnlig.")

            self.passengers[seat_number] = {
                'name': passenger_name,
                'age': passenger_age,
                'sex': passenger_sex
            }
            print("Passagerare har framgångsrikt lagts till.")
        else:
            print("Ogiltigt val. Platsnummer måste vara mellan 1-25.")

    def print_buss(self):
        print("Bus Information:")
        if not self.passengers:
            print("No passengers on the bus.")
        else:
            for seat_number, passenger_info in self.passengers.items():
                print(f"Seat number: {seat_number}, Passenger Info: {passenger_info}")

    def calc_total_age(self):
        total_age = sum(passenger_info["age"] for passenger_info in self.passengers.values())
        print(f"Total ålder av passagerare: {total_age} år")
        return total_age

    def calc_average_age(self):
        self.number_of_passengers = len(self.passengers)
        total_age = self.calc_total_age()
        if self.number_of_passengers > 0:
            average_age = total_age / self.number_of_passengers
            print(f"Genomsnittlig ålder av passagerarna är: {average_age:.2f} år")
        else:
            print("Det finns inga passagerare i bussen.")

    def max_age(self):
        if self.number_of_passengers > 0:
            passenger_with_max_age = max(self.passengers.values(), key=lambda x: x["age"])
            print(f"Passagerare med högsta ålder är: {passenger_with_max_age['name']} ({passenger_with_max_age['age']} år)")
        else:
            print("Det finns inga passagerare i bussen.")

    def find_age(self, beginning_of_age, end_of_age):
        positions = [seat_number for seat_number, passenger_info in self.passengers.items()
                      if beginning_of_age <= passenger_info["age"] <= end_of_age]

        if positions:
            print(f"Passagerare med ålder mellan {beginning_of_age} och {end_of_age} finns på positionerna: {', '.join(map(str, positions))}")
        else:
            print(f"Inga passagerare med ålder mellan {beginning_of_age} och {end_of_age} hittades.")

    def sort_buss(self):
        sorted_passengers = sorted(self.passengers.items(), key=lambda x: x[1]['age'])
        for seat_number, passenger_info in sorted_passengers:
            print(f"Seat number: {seat_number}, Passenger Info: {passenger_info}")

    def print_sex(self):
        male_passengers = [passenger_info for passenger_info in self.passengers.values() if passenger_info["sex"].lower() == "m"]
        female_passengers = [passenger_info for passenger_info in self.passengers.values() if passenger_info["sex"].lower() == "f"]

        if male_passengers:
            print("Män på bussen:")
            for male_passenger in male_passengers:
                print(f"Namn: {male_passenger['name']}, Ålder: {male_passenger['age']}")
        else:
            print("Inga manliga passagerare på bussen.")

        if female_passengers:
            print("Kvinnor på bussen:")
            for female_passenger in female_passengers:
                print(f"Namn: {female_passenger['name']}, Ålder: {female_passenger['age']}")
        else:
            print("Inga kvinnliga passagerare på bussen.")

    def poke(self):
        position_to_poke = int(input("Vilken passagerare vill du peta på? (Ange platsnummer): "))
        if 1 <= position_to_poke <= len(self.passengers):
            passenger_info = self.passengers[position_to_poke]
            print(f"Passagerare på position {position_to_poke}: '{passenger_info['name']}, Oj! Varför petar du på mig?'")
        else:
            print("Ogiltig position. Försök igen.")

    def getting_off(self):
        position_to_remove = int(input("Vilken passagerare vill du ta bort? (Ange platsnummer): "))
        if 1 <= position_to_remove <= len(self.passengers):
            removed_passenger = self.passengers.pop(position_to_remove)
            print(f"Passagerare på platsnummer {position_to_remove}: {removed_passenger['name']} har klivit av bussen.")
        else:
            print("Ogiltig position. Försök igen")

buss_instance = Buss()
buss_instance.run()