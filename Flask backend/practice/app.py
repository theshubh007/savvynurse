from flask import Flask,jsonify,request

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({'message':'Hello World!'})

@app.route('/about',methods=['POST'])
def about():
    # data=json.loads(request.data)
    # return jsonify({'message':data})  
    # return jsonify({'message':data['name']})  
    data=request.json
    name=data['name']
    return jsonify(name)


if __name__ == '__main__':
    app.run(debug=True)
    