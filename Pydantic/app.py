from flask import Flask, request, jsonify
from pydantic import BaseModel, Field, field_validator, ValidationError
import statistics
from schemas import RecipeSchema

app = Flask(__name__)

# Make sure we always return json
# Can cause issues otherwise
@app.after_request
def add_header(response):
    response.headers['Content-Type'] = 'application/json'
    return response

recipes = [
    {"id": 1, "title": "Chocolate Cheesecake", "total_price": 250, "ingredients": ["Milk", "Sugar", "Cream cheese", "Eggs"]},
    {"id": 2, "title": "Chocolate Cookies", "total_price": 400, "ingredients": ["Wheat", "Sugar", "Milk", "Eggs"]}
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

@app.get("/reset")
def reset_recipes():
    global recipes
    recipes = [
    {"id": 1, "title": "Chocolate Cheesecake", "total_price": 250,
        "ingredients": ["Milk", "Sugar", "Cream cheese", "Eggs"]},
    {"id": 2, "title": "Chocolate Cookies", "total_price": 400,
        "ingredients": ["Wheat", "Sugar", "Milk", "Eggs"]}
    ]
    return {}, 200

@app.route("/")
def status():
    return {"message": "ok"}, 200

# @app.route("/recipes")
# def list_recipes():
#    return recipes

# List endpoint with filter of max price
@app.route("/recipes", methods=["GET"])
def list_recipes():
    # max_price 200
    max_price = request.args.get("max_price", type=int)
    filtered_recipes = []
    
    if max_price:
        for recipe in recipes:
            if recipe["total_price"] < max_price:
                filtered_recipes.append(recipe)
        return filtered_recipes, 200
        
    return recipes, 200

@app.route("/recipes/<int:recipe_id>", methods=["GET"])
def get_recipe_detail(recipe_id):
    recipe = find_recipe_by_id(recipe_id=recipe_id)
    if recipe:
        return recipe, 200
    return {"message": "No recipe found"}, 404

# /recipes/search?search_query=köttbullar
@app.route("/recipes/search", methods=["GET"])
def search_recipes():
    search_query = request.args.get("search_query")
    found_recipes = []
    for recipe in recipes:
        if search_query.lower() in recipe["title"].lower():
            found_recipes.append(recipe)
    return found_recipes, 200

@app.route("/recipes", methods=["POST"])
def create_recipe():
    recipe = request.get_json()
    try:
        result = RecipeSchema(**recipe)
        recipe = result.model_dump()
    except ValidationError as e:
        return e.json(), 400
   
    recipe["id"] = get_next_id(recipes)
    recipes.append(recipe)
    return recipe, 201
        

@app.route("/recipes/<int:recipe_id>", methods=["DELETE"])
def delete_recipe(recipe_id):
    for index, recipe in enumerate(recipes.copy()):
        if recipe["id"] == recipe_id:
            recipes.pop(index)
            return {}, 204
    return {"error": "Recipe not found"}, 404

@app.route("/recipes/<int:recipe_id>", methods=["PUT"])
def update_recipe(recipe_id):
    data = request.get_json()
    try:
        result = RecipeSchema(**data)
    except ValidationError as e:
        return e.json(), 400
    
    recipe = find_recipe_by_id(recipe_id)
    if recipe:
        recipe.update(result.model_dump())
        return recipe, 200
    
    return {"error": "Recipe not found"}, 404

@app.route("/recipes/bulk", methods=["POST"])
def create_recipe_bulk():
    new_recipes = request.get_json()
    for recipe in new_recipes:
        recipe["id"] = get_next_id(recipes)
        recipes.append(recipe)
    return recipes, 200


@app.route("/recipes/average_price", methods=["GET"])
def get_average_recipe_price():
    prices = []
    for recipe in recipes:
        prices.append(recipe["total_price"])
    
    return {"average_price": statistics.mean(prices)}