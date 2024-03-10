from pydantic import BaseModel, ValidationError

data = {"first_name": "Tobias", "last_name": "Fors", "age": 30, "teacher": True}  # No error because meets the data type requirements specified in the UserShema class

# data = {"first_name": "Tobias", "last_name": "Fors", "age": 30, "teacher": "BLABLABLABLA"} # it will raise an error because data doesn't meet the data type requirements specified in the UserShema class

# Without validation
class UserSchema(BaseModel):
    first_name: str
    last_name: str
    age: int
    teacher: bool
try:
	UserSchema(**data)
except ValidationError as e:
	print(e.json())  
	# eller print(e)
	# eller print(e.errors())
