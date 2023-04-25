from flask import Flask, request, jsonify
from flask_cors import CORS
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import hashlib
import smtplib
from email.message import EmailMessage

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
    user_details = query[0].to_dict()
    idNumber = user_details['idNumber']
    return jsonify({'message': 'Profile added successfully', 'user_details': user_details}), 200


@app.route('/login', methods=['POST'])
def login():
    data = request.json
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
    # Return success message and user details
    user_details = profile.to_dict()
    return jsonify({'message': 'Login successful', 'user_details': user_details}), 200


@app.route('/users/<idNumber>', methods=['PUT'])
def update_profile(idNumber):
    data = request.json
    # Check if user exists with given idNumber
    ref = db.collection('profiles')
    query = ref.where('idNumber', '==', int(idNumber)).limit(1).get()
    if len(query) == 0:
        return jsonify({'message': 'User with idNumber does not exist'}), 404

    # Check if all required fields are present
    required_fields = ['dob', 'yearGroup', 'major', 'hasResidence', 'bestFood', 'bestMovie', 'password']
    if not all(field in data for field in required_fields):
        return jsonify({'message': 'Missing required fields'}), 400
    # Update the user's details
    doc_id = query[0].id
    profile = query[0].to_dict()
    if 'dob' in data:
        profile.update({'dob': data['dob']})
    if 'yearGroup' in data:
        profile.update({'yearGroup': data['yearGroup']})
    if 'major' in data:
        profile.update({'major': data['major']})
    if 'hasResidence' in data:
        profile.update({'hasResidence': data['hasResidence']})
    if 'bestFood' in data:
        profile.update({'bestFood': data['bestFood']})
    if 'bestMovie' in data:
        profile.update({'bestMovie': data['bestMovie']})
    if 'password' in data and data['password']:
        hashed_password = hashlib.sha256(data['password'].encode()).hexdigest()
        profile.update({'password': hashed_password})

    # Update the user's profile in the database
    ref.document(doc_id).update(profile)
    # Return success message
    return jsonify({'message': 'Profile updated successfully'}), 200


@app.route('/posts', methods=['POST'])
def add_post():
    data = request.json
    # Retrieve all users
    users_ref = db.collection('profiles')
    users = users_ref.stream()
    msg = EmailMessage()
    # Draft message content
    msg.set_content(f"A new post has been added by {data['name']}.")
    msg['Subject'] = 'Deb Social Media App : New Post Added 🎉🎉🎉'
    msg['From'] = 'debwebtechproject@gmail.com'
    # Create recipient list of all registered users
    recipients = [user.to_dict()['email'] for user in users]
    msg['Bcc'] = ', '.join(recipients)
    # send message to the list of users
    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
        smtp.login('debwebtechproject@gmail.com', 'gsovidftcdepyytu')
        smtp.send_message(msg)
    # Return success message
    return jsonify({'message': 'Post added successfully'}), 200


if __name__ == '__main__':
    app.run(debug=False)
