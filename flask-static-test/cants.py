from flask import Flask, render_template
from modules import convert_to_dict, make_ordinal

app = Flask(__name__)
application = app

# create a list of dicts from a CSV
cants_list = convert_to_dict("cants.csv")

# create a list of tuples in which the first item is the number
# (Cant) and the second item is the name (git)
pairs_list = []
for p in cants_list:
    pairs_list.append( (p['Position'], p['DickHead']) )

# first route

@app.route('/')
def index():
    return render_template('index.html', pairs=pairs_list, the_title="The Hit List")

# second route

@app.route('/cant/<num>')
def detail(num):
    try:
        cant_dict = cants_list[int(num) - 1]
    except:
        return f"<h1>Invalid value for Position: {num}</h1>"
    # a little bonus function, imported on line 2 above
    ord = make_ordinal( int(num) )
    return render_template('cants.html', pres=cant_dict, ord=ord, the_title=cant_dict['DickHead'])


# keep this as is
if __name__ == '__main__':
    app.run(debug=True)
