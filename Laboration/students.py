# Detta ar en klass som hanterar studenter.
# Ni behover inte gora nagot med koden nedanfor, utan ni ska istallet forsoka tolka koden
# Och sedan skriva sma, korta enhetstester (unit tests) i filen test_students.py
# Med hjalp av pytest
# Metoder for VG-niva ligger langre ner och ar markerade med ########## VG ##########

class StudentManagementSystem:
    def __init__(self, students=None):
        # If no students are provided, create an empty dictionary
        if students is not None:     # The "is not None" condition checks if any value other than None is passed.
            self.students = students
        else:
            self.students = {}
        
        # Variabler för VG
        self.available_courses = ["Math", "English", "Programming"]   
        self.available_grades = ["A", "B", "C", "D", "E", "F"]
  
    def add_student(self, student_id, student_info):
        # Nummer 1
        """
        This student adds a new student (should be a dictionary)
        If the student does not exist, it will raise a KeyError which can be handled with
        a try-except block
        """
        if student_id in self.students:
            raise ValueError("Student ID already exists")
        self.students[student_id] = student_info
  
    def remove_student(self, student_id):
        # Nummer 2
        """
        "This method deletes the student based on a student id"
        If the student does not exist, it will raise a KeyError which can be handled with
        a try-except block
        """
        if student_id not in self.students:
            raise KeyError("Student ID not found")
        del self.students[student_id]

    def update_student(self, student_id, updated_info):
        # Nummer 3
        """
        This student updates the student information with the new information provided
        If the student does not exist, it will raise a KeyError which can be handled with
        a try-except block
        """
        ['andrey']
        if student_id not in self.students:
            raise KeyError("Student ID not found")
        self.students[student_id].update(updated_info)

    def search_student_by_name(self, name):
        # Nummer 4
        """
        This method returns the first student that matches the name, as a dictionary
        """
        for student_id, student in self.students.items():
            if student.get("name") == name:
                return student
        raise LookupError("Student not found")
    
    def get_all_students_by_name(self, name):
        # Nummer 5 - ########## VG ##########
        """
        This method returns a list of student IDs that match the name
        """
        matching_students = []
        for student_id, info in self.students.items():
            if info.get("name") == name:
                matching_students.append(student_id)
        return matching_students

    def add_grade(self, student_id, grade, course):
        # Nummer 6 - ########## VG ##########
        """
        This method adds a grade to the student's grades
        """
        if student_id not in self.students:
            raise KeyError("Student ID not found")
        elif course not in self.available_courses:
            raise ValueError("Course not found")
        elif grade not in self.available_grades:
            raise ValueError("Grade not found")
        self.students[student_id]["grades"][course] = grade

    def get_student_grades_from_course(self, student_id, course):
        # Nummer 7 - ########## VG ##########
        """
        This method gets the student's grades from a specific course
        It will return a string with the grade
        """
        if student_id not in self.students:
            raise KeyError("Student ID not found")
        elif course not in self.available_courses:
            raise ValueError("Course not found")
        return self.students[student_id]["grades"][course]
   
   
# Nedanför ser ni lite kod för att jobba med klassen. Det är endast för att visa hur den fungerar.
# Ni behöver inte göra något med den koden, utan det är bara för att visa vad den kan göra.
# Gå steg för steg igenom koden och testa själva. Vad händer om ni gör X eller Y?

# Skapar en instance av StudentManagementSystem
# Tank pa att klassen forutsatter att ni skickar in en dictionary, dar key ar ett ID for en student
# Och value blir ytterligare en dictionary som innehaller data om studenten
# system = StudentManagementSystem(students=

# )

# # Print all students, just to show that the class has the data
# print(system.students)

# print(system.search_student_by_name("Alice"))

# # Add a student
# system.add_student("003", {"name": "Charlie", "age": 21, "grades": {"Math": "C", "English": "A"}})
# print(system.search_student_by_name("Charlie"))

# # Returns a dictionary of the student
# system.search_student_by_name("Alice")

# # Returns a list of student IDs
# print(system.get_all_students_by_name("Alice"))

# # Adding a grade to a student with the ID 001
# system.add_grade("001", "A", "Programming")
# print(system.get_student_grades_from_course("001", "Programming"))

# # Updating student 001 with new information
# system.update_student("001", {"name": "Benjamin", "age": 20, "grades": {"Math": "C", "English": "B"}})
# print(system.get_student_grades_from_course("001", "Math"))
# print(system.search_student_by_name("Benjamin"))

# # Removing a student
# system.remove_student("001")

# # Since the student does not exist, it will raise a LookupError
# try:
#     system.search_student_by_name("Benjamin")
# except LookupError:
#     print("Student not found")
    