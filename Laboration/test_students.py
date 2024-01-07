import pytest
from students import StudentManagementSystem

@pytest.fixture
def system(): 
    return StudentManagementSystem(students = {
        "001": {"name": "Alice", "age": 20, "grades": {"Math": "A", "English": "B"}},
        "002": {"name": "Bob", "age": 22, "grades": {"Programming": "B", "English": "A"}}
    })

def test_add_student(system):
    print("Add function works")
    system.add_student("003", {"name": "Charlie", "age": 21, "grades": {"Math": "C", "English": "A"}})
    assert len(system.students) == 3

def test_add_student_with_studentid_that_already_exists(system):
    print("When I try to add a student with an existing student ID, I get ValueError message.")
    with pytest.raises(ValueError, match="Student ID already exists"):   # We added match because we also want to test the error message "
        system.add_student("001", {"name": "Alex", "age": 24, "grades": {"Programming": "B", "English": "B"}})

def test_remove_student(system):
    print("Remove function works")
    system.remove_student("002")
    assert len(system.students) == 1

def test_remove_student_exception(system):
    print("When I try to remove a student with a student ID that does not exist, I receive a KeyError message.")
    with pytest.raises(KeyError, match="Student ID not found"):
        system.remove_student("004")
   
def test_update_student(system):
    print("Information update is working")
    system.update_student("001", {"name": "Charlie", "age": 22, "grades": {"Programming": "A", "English": "A"}})
    assert system.students["001"] == {"name": "Charlie", "age": 22, "grades": {"Programming": "A", "English": "A"}}
 
def test_update_nonexistent_student(system):
    print("When I try to update a student with a student ID that does not exist, I receive a KeyError message.")
    with pytest.raises(KeyError, match="Student ID not found"):
        system.update_student("003", {"name": "Charlie", "age": 21, "grades": {"Math": "C", "English": "A"}})
    
def test_search_student_by_name(system):
    print("When I search for a student by name, I can reach the first student matching that name in the system.")
    assert system.search_student_by_name("Alice") == {"name": "Alice", "age": 20, "grades": {"Math": "A", "English": "B"}}

def test_search_student_by_name_not_found(system):
    print("When I search for a student by name, if there is no name matching that name in the system, I receive a LookupError message.")
    with pytest.raises(LookupError, match="Student not found"):
        system.search_student_by_name("Charlie")
        
def test_get_all_students_by_name(system):
    print("When I search for a name it returns a list of student IDs matching the name")
    system.add_student("003", {"name": "Alice", "age": 23, "grades": {"Math": "C", "English": "B"}})
    assert system.get_all_students_by_name("Alice") == ["001", "003"]

def test_add_grade(system):
    print("Allowed grading methods can be added to the student in the system.")
    system.add_grade("002","A", "Math")
    assert system.students["002"]["grades"]["Math"] == "A"

def test_add_grade_invalid_course(system):
    print("ValueError message appears when trying to add course methods that are not allowed to the student in the system")
    with pytest.raises(ValueError, match="Course not found"):
        system.add_grade("002","A", "Geometry")

def test_get_student_grades_from_course(system):
    print("Student's grades from a specific course can be obtained")
    assert system.get_student_grades_from_course("002", "English") == "A"

def test_get_student_grades_from_course_when_course_does_not_exist(system):
    print("ValueError message appears when trying to get results from courses that are not allowed to the student in the system.")
    with pytest.raises(ValueError, match="Course not found"):
        system.get_student_grades_from_course("002", "Geometry")

# Normally, according to task, test coverage is 96%.(13 items).
# We also added the following 4 more test cases and reached 100% coverage.(17 items).We thought that it would be better.:)
def test_get_student_grades_from_student_id_when_student_id_does_not_exist(system):
    with pytest.raises(KeyError):
        system.get_student_grades_from_course("004", "Math")

def test_add_grade_invalid_grade(system):
    with pytest.raises(ValueError):
        system.add_grade("002","X", "Math")

def test_add_grade_invalid_student_id(system):
    with pytest.raises(KeyError):
        system.add_grade("004","B", "Math")

def test__init__():
    system_test = StudentManagementSystem()
    assert system_test.students == {}
    
