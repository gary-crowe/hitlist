# Flask app: cants
This is a clone and edit of a flash example for static page delivery. I used this to develp the initial idea of "thelist". These people, come the glorious revolution, will be held accountable. A bit of fun with my colleagues, in an otherwise gloomy World.  

This app is discussed in the [Flask Templates chapter](https://python-adv-web-apps.readthedocs.io/en/latest/flask3.html#) of **Python Beginners.**

## Instructions.
1. Fireup the applicaton:
```
python cants.py &
```
2. Launch a local browser and point it at socket 5000 on 'localhost'

### Adding data.
The data is created from a static csv file: cants.csv.
Edit this file and add you offenders.  Images shoould be approx 200x200px and placed in the static/images directory.
I grabbed images from `Tinternet and used imagemagik to convert to a suitable size:

```
identify -format "%wx%h" image.jpg
convert image.jpg -resize 600x400 > image.jpg
```
This example doesn't have any code to add/delete entires. That's hopefully included in the dynamic code which will run micorservices for mysql, flask & mongodb so we can run this in kubernetes.  See the python-flask-dynamic directory.

Currently a work in progress as I am still learning how to do all of this.
G.Crowe 5/1/2020

.
