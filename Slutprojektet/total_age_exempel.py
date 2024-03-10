def calc_total_age(self):
        total_age = 0
        for passenger in self.passengers:
            total_age += passenger["age"]
        print(f"Total ålder av passagerare: {total_age} år")
        return total_age

        # total_age = sum(passenger["age"] for passenger in self.passengers)