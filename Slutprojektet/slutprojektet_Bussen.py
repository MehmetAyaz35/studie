class Buss:
    def __init__(self):
        self.passengers = []
        self.number_of_passengers = 0

  


    def run(self):
        print("Välkommen till Buss-simulatorn")
        while True:
            try:
                choice = input("Välj en handling:\n1. Lägg till passagerare\n2. Visa passagerare\n3. Beräkna total ålder\n4. Beräkna genomsnittliga åldern\n5. Ta fram passagerare med högst ålder\n6. Visa alla positioner med passagerare med en viss ålder\n7. Sortera bussen efter ålder\n8. Skriv ut vilka positioner som har manliga respektive kvinnliga passagerare\n9. Hur passagerares reagerar om man petar på dom\n10. Passagerare stiger av\n0. Avsluta\nVal: ") 
                
                if choice == "1":
                    seat_number = self.number_of_passengers + 1
                    # passenger_info = {
                    #     "name": input("Ange passagerarens namn: ") 
                    # }
                    while True:
                        try:
                            passenger_info = { "name": input("Ange passagerarens namn: ") }
                            if not passenger_info["name"].isalpha():
                                raise ValueError()
                            break
                        except ValueError:
                            print("Namnet får endast innehålla bokstäver. Försök igen.")
                
                    while True:
                        try:
                            passenger_info["age"] = int(input("Ange passagerarens ålder: "))
                            break
                        except ValueError:
                            print("Åldern måste vara ett heltal. Försök igen.")

                    while True:
                        gender_input = input("Ange passagerarens kön male or female (m/f): ").lower()
                        if gender_input in {"m", "f"}:
                            passenger_info["gender"] = gender_input
                            break
                        else:
                            print("Ogiltig kön. Ange antingen 'm' eller 'f'.")

                    passenger_info["seat_number"] = seat_number
                    self.add_passenger(passenger_info)
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
            except ValueError as ve:
                print(f"Felaktig inmatning.")    
        

    def add_passenger(self, passenger_info):
        if self.number_of_passengers < 25:  
            self.passengers.append(passenger_info)
            self.number_of_passengers += 1
            print(f"{passenger_info['name']} har lagts till i bussen på plats {passenger_info['seat_number']}.")
        else:
            print("Bussen är full. Kan inte lägga till fler passagerare.")

       
    def print_buss(self):
        if not self.passengers:
            print("Bussen är tom.")
        else:
            print("Passagerare på bussen:")
            for passenger in self.passengers:
                print(passenger)

    def calc_total_age(self):
        total_age = sum(passenger["age"] for passenger in self.passengers)
        print(f"Total ålder av passagerare: {total_age} år")
        return total_age
    

    def calc_average_age(self):
        total_age = self.calc_total_age()
        if self.number_of_passengers > 0:
            average_age = total_age / self.number_of_passengers
            print(f"Genomsnittlig ålder av passagerarna är: {average_age:.2f} år") 
        else:
            print("Det finns inga passagerare i bussen.")
    

    def max_age(self):
        if self.number_of_passengers > 0:
            passenger_with_max_age = max(self.passengers, key=lambda x: x["age"])
            print(f"Passagerare med högsta ålder är: {passenger_with_max_age['name']} ({passenger_with_max_age['age']} år)")
        else:
            print("Det finns inga passagerare i bussen.")


    def find_age(self, beginning_of_age, end_of_age):
        positions = [i + 1 for i, passenger in enumerate(self.passengers) if beginning_of_age <= passenger["age"] <= end_of_age]

        if positions:
            print(f"Passagerare med ålder mellan {beginning_of_age} och {end_of_age} finns på positionerna: {', '.join(map(str, positions))}")
        
        else:
            print(f"Inga passagerare med ålder mellan {beginning_of_age} och {end_of_age} hittades.")


    def sort_buss(self):
        # I sorted the passengers based on age
        self.passengers.sort(key=lambda x: x['age'])

        # I can print information about each passenger along with their position and seat number
        for i, passenger in enumerate(self.passengers, start=1):
            print(f"Plats {passenger['seat_number']} : {passenger['age']} years old")
            
    def print_sex(self):
        male_passengers = [passenger for passenger in self.passengers if passenger["gender"].lower() == "m"]
        female_passengers = [passenger for passenger in self.passengers if passenger["gender"].lower() == "f"]

        if male_passengers:
            print("Män på bussen:")
            for male_passenger in male_passengers:
                print(f"Plats {male_passenger['seat_number']} : {male_passenger['name']} ({male_passenger['age']} år)")

        if female_passengers:
            print("Kvinnor på bussen:")
            for female_passenger in female_passengers:
                print(f"Plats {female_passenger['seat_number']} : {female_passenger['name']} ({female_passenger['age']} år)")

        if not male_passengers and not female_passengers:
            print("Det finns inga manliga eller kvinnliga passagerare på bussen.")

    def poke(self):
        position_to_poke = int(input("Vilken passagerare vill du peta på? (Ange position): "))
        if 1 <= position_to_poke <= self.number_of_passengers:
            print(f"Passagerare på position {position_to_poke}: 'Oj! Varför petar du på mig?'")
        else:
            print("Ogiltig position. Försök igen.")

    def getting_off(self):
        if not self.passengers:
            print("Det finns inga passagerare på bussen.")
            return

        position_to_get_off = int(input("Vilken passagerare vill stiga av? (Ange position): "))
        if 1 <= position_to_get_off <= self.number_of_passengers:
            passenger_to_get_off = self.passengers[position_to_get_off - 1]
            print(f"Passagerare på position {position_to_get_off} ({passenger_to_get_off['name']}) har stigit av.")
            self.passengers.pop(position_to_get_off - 1)
            self.number_of_passengers -= 1

            # i can add a new passenger to the vacant seat
            seat_number = passenger_to_get_off['seat_number']
            new_passenger_info = {
                "name": input("Ange den nya passagerarens namn: "),
                "age": int(input("Ange den nya passagerarens ålder: ")),
                "gender": input("Ange den nya passagerarens kön (m/f): "),
                "seat_number": seat_number
            }
            
            self.add_passenger(new_passenger_info)
        else:
            print("Ogiltig position. Försök igen.")

    
class Program:                   # The Program class serves as a container for the initialization and execution of a bus simulation
    def __init__(self, *args):
        minbuss = Buss()
        minbuss.run()
         
    

if __name__ == "__main__":    # if __name__ == "__main__": ensures that the code within this block is only executed when the script    
    my_program = Program()    # is run directly, not when it's imported as a module.
