from flask import Flask, request

app = Flask(__name__)

@app.route('/example')
def example():
    # Retrieve the value of the 'name' parameter from the query string
    name = request.args.get('name')

    # Retrieve the value of the 'age' parameter with a default value of 18
    age = request.args.get('age', default=18)

    return f"Name: {name}, Age: {age}"

if __name__ == '__main__':
    app.run(debug=True)

