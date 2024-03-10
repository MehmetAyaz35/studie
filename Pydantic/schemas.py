from pydantic import BaseModel, Field, field_validator, ValidationError, validator 

class RecipeSchema(BaseModel):
    title: str = Field(min_length=2, max_length=50)
    total_price: int | None = Field(default=None, lt=1000000, gt=0)
    ingredients:list[str]

    
    @field_validator('ingredients')
    @classmethod
    def validate_profanity(cls, value: list[str]):
        curse_words = ["crap", "kelb"]
        for ingredient in value:
            if ingredient in curse_words:
                raise ValueError(f'{ingredient} not allowed, profanity')
        return value
    
# recipe = {"title": "Cake", "price": 250, "ingredients": ["Milk", "Sugar", "Eggs", "kelb"]}  
# recipe_instance = RecipeSchema(**recipe)
    
