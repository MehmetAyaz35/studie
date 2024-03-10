from flask import Flask

app = Flask(__name__)

from flask import Flask, request, jsonify  # imported Flask class from the flask module   # This code is a basic implementation of a RESTful API using the Flask web framework in Python
import json
app = Flask(__name__)    # created a Flask application instance named app  


@app.route('/')   # I have a route ('/') that responds with a welcome message when the root URL is accessed.
def home():
    return "Welcome to my Flask REST API!"


with open('users.json', 'r') as file:    # The code reads user data from a file named 'users.json' and 
    users = json.load(file)              # loads it into a variable named users. json.load() returns JSON object as a dictionary 

def write_to_json(data, filename):       # this fuction writes data to a JSON file with specified indentation.
    with open(filename, 'w') as file:
        json.dump(data, file, indent=2)  # the resulting file object is assigned to the file variable within the with block. json.dump returns(converts) the Python objects into appropriate json objects.


@app.route('/users', methods=['GET'])
def get_users():
    return {"users": users, "message": "Hi"}, 200


@app.route('/users-filtered', methods=['GET'])
def get_users_filtered():
    role = request.args.get('role')
    limit = request.args.get('limit', type=int)
    filtered_users = users

    if role:
        filtered_users = []
        for user in users:
            if user["role"].lower() == role.lower():
                filtered_users.append(user)
    if limit is not None and limit > 0:
        filtered_users = filtered_users[:limit]
    return filtered_users, 200    


@app.route('/users/<int:user_id>', methods=['GET'])  # In Flask, @app.route is a decorator that is used to associate a function with a specific URL route.
def get_user(user_id):
    found_user = None
    for user in users:
        if user["id"] == user_id:
            found_user = user
            break
    if found_user:
        return found_user, 200
    return "User not found", 404


@app.route('/user', methods=['POST'])
def add_user():
    return "Mehmet", 200


@app.route('/users', methods=['POST'])
def create_user():
    new_user = request.get_json()
    for user in users:
        if new_user["id"] == user["id"]:
            return "ID already exists", 412 
    users.append(new_user)
    write_to_json(users, 'users.json')
    return jsonify(new_user), 201
    # return new_user, 201


@app.route('/users/<int:user_id>', methods=['DELETE']) 
def delete_user(user_id):
    foundUser = None
    for user in users:
        if user["id"] == user_id:
            foundUser = user
            users.remove(user)
            break
    if foundUser:
        write_to_json(users, 'users.json')
        return "", 202
    return "User not found", 404


# @app.route('/users/<int:user_id>', methods=['PUT'])
# def update_user(user_id):
#     data = request.get_json()
#     foundUser = False
#     for user in users:
#         if user["id"] == user_id:
#             foundUser = True
#             if "name" in data:
#                 user["name"] = data["name"]
#             if "role" in data:
#                 user["role"] = data["role"]
#             break
#     if foundUser:
#         write_to_json(users, 'users.json')
#         return jsonify(user), 200
#     return "User not found", 404

@app.route('/users/<int:user_id>', methods=['PUT'])
def update_user(user_id):
    """Uppdatera en användares information."""
    user_data = request.get_json()
    for user in users:
        if user['id'] == user_id:
            user['name'] = user_data['name']
            user['role'] = user_data['role']
            return user, 200
    return {'message': 'Användare inte hittad'}, 404


# data: This parameter represents the data that you want to write to the JSON file. It could be a dictionary, list, or any other JSON-serializable data structure.

# filename: This parameter represents the name of the file to which you want to write the JSON data or from which you want to read JSON data. It is a string that includes the file name and extension (e.g., 'output.json').

# write_to_json({"name": "John", "age": 25}, 'output.json')
# In this example, 'output.json' is the filename. The open function opens this file in write mode ('w'), and the resulting file object is assigned to the file variable within the with block.


# new_user = request.get_json(): This line uses Flask's request object to retrieve the JSON data from the incoming POST request. The get_json() method parses the JSON data from the request body and returns a Python dictionary representing the JSON payload. This assumes that the incoming data is in JSON format.
#  In summary, this route is designed to handle POST requests to the '/users' endpoint. When a POST request is received, the JSON data from the request body is extracted and stored in the new_user variable, allowing further processing or storage of the user information in the application.



    


