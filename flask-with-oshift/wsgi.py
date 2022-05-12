# Imports first
import os, pymysql
from datetime import date
from flask import Flask, render_template, request, flash
from flask_bootstrap import Bootstrap
from flask_wtf import FlaskForm
from wtforms import SubmitField, SelectField, RadioField, HiddenField, StringField, IntegerField, FloatField
from wtforms.validators import InputRequired, Length, Regexp, NumberRange
from modules import convert_to_dict, make_ordinal
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import text

# check for environment variables. These will get passed from Openshift and setup the user/DB etc
if not os.getenv("MYSQL_HOST"):
    raise RuntimeError("Oops!  MYSQL_HOST is not set")

if not os.getenv("MYSQL_DATABASE"):
    raise RuntimeError("Oops!  MYSQL_DATABASE is not set")

if not os.getenv("MYSQL_USER"):
    raise RuntimeError("Oops!  MYSQL_USER is not set")

if not os.getenv("MYSQL_PASSWORD"):
    raise RuntimeError("Oops!  MYSQL_PASSWORD is not set")

userpass = 'mysql+pymysql://' + os.getenv("MYSQL_USER") + ':' + os.getenv("MYSQL_PASSWORD") + '@'

app = Flask(__name__) # app id the Flask Class
application = app

# Put together a string that shows SQLAlchemy where the database is
app.config['SQLALCHEMY_DATABASE_URI'] = userpass + os.getenv("MYSQL_HOST") + "/" + os.getenv("MYSQL_DATABASE")
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['SECRET_KEY'] = 'OadkAPVqDYO3g7ZHmyFFuESfpvzloSFI'

# this variable, db, will be used for all SQLAlchemy commands
db = SQLAlchemy(app)
# Where we are in the list
pointer = 0

# each table in the database needs a class to be created for it
# identify all columns by name and data type
# Databse fileds: id,Name,Wikipedia-entry,Crime,Sentence,Image
# For multiuser, we probably want to add username - TODO

class Gits(db.Model):
    __tablename__ = 'gits'
    position = db.Column(db.Integer, primary_key=True)
    offender = db.Column(db.String)
    wiki = db.Column(db.String)
    crime = db.Column(db.String)
    punishment = db.Column(db.String)
    image = db.Column(db.String)
    created_at = db.Column(db.String)
    def __init__(self, position, offender, wiki, crime, punishment, image, created_at):
        self.position = position
        self.offender = offender
        self.wiki = wiki
        self.crime = crime
        self.punishment = punishment
        self.image = image
        self.created_at = created_at

class AddRecord(FlaskForm):
    position = HiddenField()
    offender = StringField('Offenders name or thing you detest')
    wiki = StringField('Wikipedia entry')
    crime = StringField('The Crime')
    punishment = StringField('The Punishment')
    image = StringField('jpg image location')
    created_at = HiddenField()
    submit = SubmitField('Add/Update Record')

# Flask-Bootstrap requires this line
Bootstrap(app)

def stringdate():
    today = date.today()
    date_list = str(today).split('-')
    # build string in format 01-01-2000
    date_string = date_list[1] + "-" + date_list[2] + "-" + date_list[0]
    return date_string

# first route : index.html
@app.route('/')
def index():
    # Create a list of entries from database
    pairs_list = []

    for p in Gits.query.order_by(Gits.position).all():
        pairs_list.append( (p.position, p.offender) )

    return render_template('index.html', pairs=pairs_list, pointer=pointer)

# second route : Show specific offender
@app.route('/cant/<num>')
def detail(num):
    try:
        ###### Select entry from DB using position parameter
        Found = Gits.query.filter_by(position=num).first()
    except:
        return f"<h1>Invalid value for Position: {num}</h1>"
    
    ord = make_ordinal( int(num) )
    return render_template('cants.html', pres=Found, ord=ord, total=Gits.query.count())

# route : back.html When back button pressed, go back 12 spaces through list
@app.route('/back')
def back():

    global pointer # Use the global variable
    pointer = pointer-12
    if pointer < 0:
      pointer = 0

    # Create a list of entries from database
    pairs_list = []

    for p in Gits.query.order_by(Gits.position).all():
        pairs_list.append( (p.position, p.offender) )

    return render_template('index.html', pairs=pairs_list, pointer=pointer)

# route : display next 12 entries
@app.route('/forward')
def forward():

    global pointer # Use the global variable
    pointer = pointer+12
    if pointer > total=Gits.query.count():
       pointer = total=Gits.query.count() - 12

    # Create a list of entries from database
    pairs_list = []

    for p in Gits.query.order_by(Gits.position).all():
        pairs_list.append( (p.position, p.offender) )

    return render_template('index.html', pairs=pairs_list, pointer=pointer)

# ################################## #
# Add a new Offender to the database
# ################################## #
@app.route('/add_record', methods=['GET', 'POST'])
def add_record():
    form1 = AddRecord()
    if form1.validate_on_submit():
        # position = request.form['position']
        position = total=Gits.query.count()+1
        offender = request.form['offender']
        wiki = request.form['wiki']
        crime = request.form['crime']
        punishment = request.form['punishment']
        image = request.form['image']
        created_at = stringdate()
        record = Gits(position,offender, wiki, crime, punishment, image, created_at)
        # Flask-SQLAlchemy magic adds record to database
        db.session.add(record)
        db.session.commit()

        # create a message to send to the template
        message = f"The data for offender {offender} has been submitted."
        return render_template('add_record.html', message=message)
    else:
        for field, errors in form1.errors.items():
            for error in errors:
                flash("Error in {}: {}".format(
                    getattr(form1, field).label.text,
                    error
                ), 'error')
        return render_template('add_record.html', form1=form1)

# If run from Python directly, launch in debug mode
if __name__ == '__main__':
    app.run(debug=True)
