from pydantic import BaseModel, validator

class YourModel(BaseModel):
    title: str

    @validator("title")
    def title_big(cls, v):
        if v.upper() != v:
            raise ValueError("Title must be in uppercase")
        return v

# Example usage
data = {"title": "some TITLE"}
model_instance = YourModel(**data)

