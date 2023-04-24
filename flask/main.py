from flask import Flask, request, jsonify
from flask_cors import CORS
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import hashlib

cred = credentials.Certificate("webtechproject-1-firebase-adminsdk-8p0td-773de43594.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

app = Flask(__name__)
CORS(app)

@app.route('/users', methods=['POST'])
def add_profile():
    data = request.json
    # Check if required fields are provided
    required_fields = ['idNumber', 'name', 'email', 'dob', 'yearGroup', 'major', 'hasResidence', 'bestFood',
                       'bestMovie', 'password']
    if not all(field in data for field in required_fields):
        return jsonify({'message': 'Missing required fields'}), 400

    # Check if user already exists with id number or email
    ref = db.collection('profiles')
    query = ref.where('idNumber', '==', data['idNumber']).limit(1).get()
    if len(query) > 0:
        return jsonify({'message': 'User with idNumber already exists'}), 400
    query = ref.where('email', '==', data['email']).limit(1).get()
    if len(query) > 0:
        return jsonify({'message': 'User with email already exists'}), 400

    # Hash the password
    password = data['password']
    hashed_password = hashlib.sha256(password.encode()).hexdigest()

    # Add user to Firestore
    new_profile = ref.document()
    new_profile.set({
        'idNumber': data['idNumber'],
        'name': data['name'],
        'email': data['email'],
        'dob': data['dob'],
        'yearGroup': data['yearGroup'],
        'major': data['major'],
        'hasResidence': data['hasResidence'],
        'bestFood': data['bestFood'],
        'bestMovie': data['bestMovie'],
        'password': hashed_password
    })

    # Log in the user and return success message and idNumber
    query = ref.where('email', '==', data['email']).limit(1).get()
    user_data = query[0].to_dict()
    idNumber = user_data['idNumber']
    return jsonify({'message': 'Profile added successfully', 'idNumber': idNumber}), 200

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    print(data)
    # Check if required fields are provided
    required_fields = ['email', 'password']
    if not all(field in data for field in required_fields):
        return jsonify({'message': 'Missing required fields'}), 400
    # Check if user exists with given email
    ref = db.collection('profiles')
    query = ref.where('email', '==', data['email']).limit(1).get()
    if len(query) == 0:
        return jsonify({'message': 'Invalid email or password'}), 401
    # Check if password is correct
    profile = query[0]
    hashed_password = hashlib.sha256(data['password'].encode()).hexdigest()
    if hashed_password != profile.get('password'):
        return jsonify({'message': 'Invalid email or password'}), 401

    # Return success message and user ID and idNumber
    user_id = profile.id
    id_number = profile.get('idNumber')
    return jsonify({'message': 'Login successful', 'user_id': user_id, 'idNumber': id_number}), 200


if __name__ == '__main__':
    app.run(debug=False)