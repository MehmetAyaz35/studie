import pytest
from app import app

BASE_URL = "http://localhost:5000" 

@pytest.fixture()
def client():
    test_client = app.test_client()
    test_client.get(f"{BASE_URL}/reset")
    return test_client

@pytest.mark.status
def test_status(client):
    response = client.get(f"/")
    assert response.status_code == 200

@pytest.mark.read
def test_list_recipes(client):
    response = client.get(f"{BASE_URL}/recipes")
    assert response.status_code == 200
    assert isinstance(response.get_json(), list)

@pytest.mark.read
def test_get_detail_valid(client):
    response = client.get(f"{BASE_URL}/recipes/1")
    assert response.status_code == 200
    assert isinstance(response.get_json(), dict)
    assert response.get_json()["id"] == 1
    assert response.get_json()["title"] == "Chocolate Cheesecake"

# This is similar to pytest.raises()
@pytest.mark.get
def test_get_detail_invalid(client):
    response = client.get(f"{BASE_URL}/recipes/12131312321321321321321321414312312321")
    assert response.status_code == 404

@pytest.mark.get
def test_get_detail_invalid_correct_message(client):
    response = client.get(f"{BASE_URL}/recipes/12131312321321321321321321414312312321")
    assert response.status_code == 404
    assert isinstance(response.get_json(), dict)
    assert "message" in response.get_json()

@pytest.mark.post
def test_create_recipe(client):
    new_recipe = {
        "title": "Hamburgare",
        "total_price": 500,
        "ingredients": ["Bröd", "Kött", "Salt", "Ketchup"]
    }
    response = client.post(f"{BASE_URL}/recipes", 
                             json=new_recipe
                             )
    data = response.get_json()
    assert response.status_code == 201 # created
    assert isinstance(data, dict)
    assert "id" in data
    assert data["id"] == 3
    assert "title" in data
    assert "ingredients" in data
    assert "total_price" in data
    
    response2 = client.get(f"{BASE_URL}/recipes")
    assert len(response2.get_json()) > 0

@pytest.mark.post
@pytest.mark.recipe_validation
def test_post_short_title(client):
    new_recipe = {
        "title": "H",
        "total_price": 500,
        "ingredients": ["Bröd", "Kött", "Salt", "Ketchup"]
    }
    response = client.post(f"{BASE_URL}/recipes", json=new_recipe)
    assert response.status_code == 400
    assert response.get_json()[0]["type"] == "string_too_short"

@pytest.mark.post
@pytest.mark.recipe_validation
def test_post_invalid_long_length_title(client):
    new_recipe = {
        "title": "HsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsaHsadasdasdsa",
        "total_price": 500,
        "ingredients": ["Bröd", "Kött", "Salt", "Ketchup"]
    }
    response = client.post(f"{BASE_URL}/recipes", json=new_recipe)
    assert response.status_code == 400
    assert response.get_json()[0]["type"] == "string_too_long"

@pytest.mark.post
@pytest.mark.recipe_validation
def test_post_invalid_total_price(client):
    new_recipe = {
        "title": "Köttbullar",
        "total_price": -5,
        "ingredients": ["Bröd", "Kött", "Salt", "Ketchup"]
    }
    response = client.post(f"{BASE_URL}/recipes", json=new_recipe)
    assert response.status_code == 400
    assert response.get_json()[0]["type"] == "greater_than"

@pytest.mark.post
@pytest.mark.recipe_validation
def test_post_recipe_profanity(client):
    new_recipe = {
        "title": "Köttbullar",
        "total_price": 100,
        "ingredients": ["Bröd", "Kött", "Salt", "crap"] # invalid word
    }
    response = client.post(f"{BASE_URL}/recipes", json=new_recipe)
    assert response.status_code == 400
    assert response.get_json()[0]["type"] == "value_error"
    assert "ingredients" in response.get_json()[0]["loc"]

@pytest.mark.put
def test_update_recipe_404(client):
    new_recipe = {
        "title": "Köttbullar",
        "total_price": 100,
        "ingredients": ["Bröd", "Kött", "Salt"]
    }
    response = client.put(f"{BASE_URL}/recipes/999999999999999", json=new_recipe)
    data = response.get_json()
    assert response.status_code == 404
    assert "error" in data


@pytest.mark.put
def test_update_recipe(client):
    new_recipe = {
        "title": "Köttbullar",
        "total_price": 100,
        "ingredients": ["Bröd", "Kött", "Salt"]
    }
    response = client.put(f"{BASE_URL}/recipes/2", json=new_recipe)
    data = response.get_json()
    assert response.status_code == 200
    assert data["title"] == "Köttbullar"
    assert data["id"] == 2
    assert data["total_price"] == 100
    response = client.get(f"{BASE_URL}/recipes/2")
    data = response.get_json()
    assert data["title"] == "Köttbullar"
    


# Test to make sure that we can delete a recipe that exists
# And we double check that it actually was deleted
# by performing a get-request to a recipe detail endpoint
@pytest.mark.delete
def test_delete_recipe(client):
    response = client.delete(f"{BASE_URL}/recipes/2")
    assert response.status_code == 204
    response = client.get(f"{BASE_URL}/recipes/2")
    assert response.status_code == 404


# Test to make sure that when we try to delete
# a recipe that does not exist, we get 404
@pytest.mark.delete
def test_delete_recipe_404(client):
    response = client.delete(f"{BASE_URL}/recipes/999999999999999")
    data = response.get_json()
    assert response.status_code == 404
    assert "error" in data


@pytest.mark.get
def test_search_recipe(client):
    search_query = "chocolate"
    response = client.get(f"{BASE_URL}/recipes/search?search_query={search_query}")
    assert response.status_code == 200
    data = response.get_json()
    found = False
    for recipe in data:
        if search_query.lower() in recipe["title"].lower():
            found = True
            
    assert found == True