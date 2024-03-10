from pydantic import BaseModel


data = {"first_name": "Tobias", "last_name": "Fors", "age": 30, "teacher": True}

class UserSchema(BaseModel):
    first_name: str
    last_name: str
    age:int
    teacher: bool

UserSchema(**data)



# UserSchema(first_name = "Mehmet", last_name ="Ayaz")


