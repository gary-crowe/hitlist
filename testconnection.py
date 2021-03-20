"""
test for a MySQL database connection on your hosted website
both the database and this script must be on the server
"""
import os
import pymysql
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import text

# check for environment variables.
#if not os.getenv("DATABASE_URL"):
#    raise RuntimeError("DATABASE_URL is not set")
#if not os.getenv("DATABASE_NAME"):
#    raise RuntimeError("DATABASE_NAME is not set")
#if not os.getenv("USERNAME"):
#    raise RuntimeError("USERNAME is not set")
#if not os.getenv("PASSWORD"):
#    raise RuntimeError("PASSWORD is not set")

app = Flask(__name__)
application = app

# make sure the username, password and database name are correct
username = 'gary'
password = 'redhat'
userpass = 'mysql+pymysql://' + os.getenv("USERNAME") + ':' + os.getenv("PASSWORD") + '@'
# keep this as is for a hosted website
server  = '127.0.0.1'
# change to YOUR database name, with a slash added as shown
dbname   = '/offenders'
# no socket

# put them all together as a string that shows SQLAlchemy where the database is
# app.config['SQLALCHEMY_DATABASE_URI'] = userpass + os.getenv("DATABASE_URL") + os.getenv("DATABASE_NAME")
app.config['SQLALCHEMY_DATABASE_URI'] = userpass + server + dbname

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True

# this variable, db, will be used for all SQLAlchemy commands
db = SQLAlchemy(app)

# NOTHING BELOW THIS LINE NEEDS TO CHANGE
# this route will test the database connection and nothing more
@app.route('/')
def testdb():
    try:
        db.session.query('1').from_statement(text('SELECT 1')).all()
        return '<h1>It works.</h1>'
    except Exception as e:
        # see Terminal for description of the error
        print("\nThe error:\n" + str(e) + "\n")
        return '<h1>Something is broken.</h1>'

if __name__ == '__main__':
    app.run(debug=True)