from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/ocp_website')
def ocp_website():
    ocp_url = 'http://example.com'  # Replace with the actual URL
    return render_template('ocp_website.html', ocp_url=ocp_url)

@app.route('/powerbi_visuals_d')
def powerbi_visuals_d():
    return render_template('powerbi_visuals_d.html')

@app.route('/powerbi_visuals_r')
def powerbi_visuals_r():
    return render_template('powerbi_visuals_r.html')

@app.route('/corrective_logical_frameworks')
def corrective_logical_frameworks():
    return render_template('corrective_logical_frameworks.html')

if __name__ == '__main__':
    app.run(debug=True)
