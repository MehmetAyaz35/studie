from flask import Flask, request
app = Flask(__name__)

recipes = [
    {"id": 1, "title": "Cheesecake", "price": 250, "ingredients": ["Milk", "Sugar", "Cream cheese", "Eggs"]},
    {"id": 2, "title": "Cookies", "price": 400, "ingredients": ["Wheat", "Sugar", "Milk", "Eggs"]}
    # Lägg till fler recept här
]

# Hjälpfunktioner
def find_recipe_by_id(recipe_id):
    """Find recipe by ID"""
    for recipe in recipes:
        if recipe["id"] == recipe_id:
            return recipe
    return None


def get_next_id(data: list):
    """
    This function will automatically generate a new ID for a student.
    """
    if not data:
        return 1
    return max(d['id'] for d in data) + 1

@app.route("/")
def home():
    return "Welcome to our delicious recipes"

@app.route("/recipes")
def all_recipes():
    return recipes
    
@app.route("/recipes/search")
def search_recipes():
    search_query = request.args.get("search_query")
    found_recipes = []
    for recipe in recipes:
        if search_query.lower() in recipe["title"].lower():
            found_recipes.append(recipe)
    return found_recipes, 200