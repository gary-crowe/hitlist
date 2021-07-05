from flask import Flask, render_template
from modules import convert_to_dict, make_ordinal

app = Flask(__name__)
application = app

# create a list of dicts from a CSV
offenders_list = convert_to_dict("thelist.csv")

# create a list of tuples in which the first item is the number
# (Cant) and the second item is the name (git)
pairs_list = []
for p in offenders_list:
    pairs_list.append( (p['Position'], p['Idiot']) )

# first route

@app.route('/')
def index():
    return render_template('index.html', pairs=pairs_list, the_title="The Hit List")

# second route

@app.route('/cant/<num>')
def detail(num):
    try:
        offenders_dict = offenders_list[int(num) - 1]
    except:
        return f"<h1>Invalid value for Position: {num}</h1>"
    # a little bonus function, imported on line 2 above
    ord = make_ordinal( int(num) )
    return render_template('offenders.html', pres=offenders_dict, ord=ord, the_title=offenders_dict['Idiot'])


if __name__ == '__main__':
    app.run(debug=True)
