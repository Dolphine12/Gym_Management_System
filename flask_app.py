from flask import Flask, request, jsonify, abort

app = Flask(__name__)

# demo data  store
memberships = {}
next_id = 1 # simple auto-incrementing ID

@app.route('/memberships', methods=['POST'])
def create_membership():
    global next_id
    data = request.get_json()
    if not data or 'name' not in data or 'email' not in data:
        abort(400, 'Missing required fields')
    membership = {
        'id': next_id,
        'name': data['name'],
        'email': data['email'],
        'membership_type': data.get('membership_type', 'standard')
    }
    memberships[next_id] = membership
    next_id += 1
    return jsonify(membership), 201

@app.route('/memberships', methods=['GET'])
def get_memberships():
    return jsonify(list(memberships.values()))

@app.route('/memberships/<int:membership_id>', methods=['GET'])
def get_membership(membership_id):
    membership = memberships.get(membership_id)
    if not membership:
        abort(404, 'Membership not found')
    return jsonify(membership)

@app.route('/memberships/<int:membership_id>', methods=['PUT'])
def update_membership(membership_id):
    membership = memberships.get(membership_id)
    if not membership:
        abort(404, 'Membership not found')
    data = request.get_json()
    membership['name'] = data.get('name', membership['name'])
    membership['email'] = data.get('email', membership['email'])
    membership['membership_type'] = data.get('membership_type', membership['membership_type'])
    return jsonify(membership)

@app.route('/memberships/<int:membership_id>', methods=['DELETE'])
def delete_membership(membership_id):
    if membership_id not in memberships:
        abort(404, 'Membership not found')
    del memberships[membership_id]
    return '', 204

if __name__ == '__main__':
    app.run(debug=True)