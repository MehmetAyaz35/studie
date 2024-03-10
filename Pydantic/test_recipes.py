import pytest
import requests

BASE_URL = "http://localhost:5000" 

@pytest.fixture()
def reset_data():
    requests.get(f"{BASE_URL}/reset")
    return

@pytest.mark.status
def test_status():
    response = requests.get(f"{BASE_URL}")
    assert response.status_code == 200

@pytest.mark.read
def test_list_recipes():
    response = requests.get(f"{BASE_URL}/recipes")
    assert response.status_code == 200
    assert isinstance(response.json(), list)

@pytest.mark.read
def test_get_detail_valid():
    response = requests.get(f"{BASE_URL}/recipes/1")
    assert response.status_code == 200
    assert isinstance(response.json(), dict)
    assert response.json()["id"] == 1
    assert response.json()["title"] == "Chocolate Cheesecake"

# This is similar to pytest.raises()
@pytest.mark.get
def test_get_detail_invalid():
    response = requests.get(f"{BASE_URL}/recipes/12131312321321321321321321414312312321")
    assert response.status_code == 404

@pytest.mark.get
def test_get_detail_invalid_correct_message():
    response = requests.get(f"{BASE_URL}/recipes/12131312321321321321321321414312312321")
    assert response.status_code == 404
    assert isinstance(response.json(), dict)
    assert "message" in response.json()

@pytest.mark.post
def test_create_recipe(reset_data):
    new_recipe = {
        "title": "Hamburgare",
        "total_price": 500,
        "ingredients": ["Bröd", "Kött", "Salt", "Ketchup"]
    }
    response = requests.post(f"{BASE_URL}/recipes", 
                             json=new_recipe
                             )
    data = response.json()
    assert response.status_code == 201 # created
    assert isinstance(data, dict)
    assert "id" in data
    assert "title" in data
    assert "ingredients" in data
    assert "total_price" in data
    
    response2 = requests.get(f"{BASE_URL}/recipes")
    assert len(response2.json()) > 0

@pytest.mark.post
@pytest.mark.recipe_validation
def test_post_short_title(reset_data):
    new_recipe = {
        "title": "H",
        "total_price": 500,
        "ingredients": ["Bröd", "Kött", "Salt", "Ketchup"]
    }
    response = requests.post(f"{BASE_URL}/recipes", json=new_recipe)
    assert response.status_code == 400
    assert response.json()[0]["type"] == "string_too_short"

@pytest.mark.post
@pytest.mark.recipe_validation
def test_post_invalid_long_length_title(reset_data):
    new_recipe = {
        "title": "HsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsa",
        "total_price": 500,
        "ingredients": ["Bröd", "Kött", "Salt", "Ketchup"]
    }
    response = requests.post(f"{BASE_URL}/recipes", json=new_recipe)
    assert response.status_code == 400
    assert response.json()[0]["type"] == "string_too_long"

@pytest.mark.post
@pytest.mark.recipe_validation
def test_post_invalid_total_price(reset_data):
    new_recipe = {
        "title": "Köttbullar",
        "total_price": -5,
        "ingredients": ["Bröd", "Kött", "Salt", "Ketchup"]
    }
    response = requests.post(f"{BASE_URL}/recipes", json=new_recipe)
    assert response.status_code == 400
    assert response.json()[0]["type"] == "greater_than"

@pytest.mark.post
@pytest.mark.recipe_validation
def test_post_recipe_profanity(reset_data):
    new_recipe = {
        "title": "Köttbullar",
        "total_price": 100,
        "ingredients": ["Bröd", "Kött", "Salt", "crap"] # invalid word
    }
    response = requests.post(f"{BASE_URL}/recipes", json=new_recipe)
    assert response.status_code == 400
    assert response.json()[0]["type"] == "value_error"
    assert "ingredients" in response.json()[0]["loc"]



@pytest.mark.put
def test_update_recipe_404():
    new_recipe = {
        "title": "Köttbullar",
        "total_price": 100,
        "ingredients": ["Bröd", "Kött", "Salt"]
    }
    response = requests.put(f"{BASE_URL}/recipes/999999999999999", json=new_recipe)
    data = response.json()
    assert response.status_code == 404
    assert "error" in data


@pytest.mark.put
def test_update_recipe(reset_data):
    new_recipe = {
        "title": "Köttbullar",
        "total_price": 100,
        "ingredients": ["Bröd", "Kött", "Salt"]
    }
    response = requests.put(f"{BASE_URL}/recipes/2", json=new_recipe)
    data = response.json()
    assert response.status_code == 200
    assert data["title"] == "Köttbullar"
    assert data["id"] == 2
    assert data["total_price"] == 100
    response = requests.get(f"{BASE_URL}/recipes/2")
    data = response.json()
    assert data["title"] == "Köttbullar"

@pytest.mark.delete
def test_delete_recipe(reset_data):
    response = requests.delete(f"{BASE_URL}/recipes/2")
    assert response.status_code == 204
    response = requests.get(f"{BASE_URL}/recipes/2")
    assert response.status_code == 404


@pytest.mark.delete
def test_delete_recipe_404(reset_data):
    response = requests.delete(f"{BASE_URL}/recipes/999999999999999")
    data = response.json()
    assert response.status_code == 404
    assert "error" in data


@pytest.mark.get
def test_search_recipe(reset_data):
    search_query = "chocolate"
    response = requests.get(f"{BASE_URL}/recipes/search?search_query={search_query}")
    assert response.status_code == 200
    data = response.json()
    found = False
    for recipe in data:
        if search_query.lower() in recipe["title"].lower():
            found = True  
    assert found == True