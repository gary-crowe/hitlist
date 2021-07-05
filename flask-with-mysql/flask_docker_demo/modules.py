"""
functions to be imported into the presidents Flask app
"""

def convert_to_dict():
    """
    Read the database and convert to a Dictionary.
    As it grows, then this probably needs to return a random , limited number.
    """

    # create a regular Python list containing dicts
    list_of_dicts = Gits.query.order_by(Gits.position).all()

    # return the list
    return list_of_dicts


def make_ordinal(num):
    """
    Create an ordinal (1st, 2nd, etc.) from a number.
    """
    base = num % 10
    if base in [0,4,5,6,7,8,9] or num in [11,12,13]:
        ext = "th"
    elif base == 1:
        ext = "st"
    elif base == 2:
        ext = "nd"
    else:
        ext = "rd"
    return str(num) + ext

# tryouts
def test_make_ordinal():
    for i in range(1,46):
        print(make_ordinal(i))

def search_the_list(list):
    for item in list:
        if "Whig" in item['Party']:
            print(item['President'] + " was a Whig.")
    for k in list[0].keys():
        print(k)

# run tryouts
if __name__ == '__main__':
    test_make_ordinal()
    presidents_list = convert_to_dict("cants.csv")
    search_the_list(presidents_list)
    print(make_ordinal(12))
    print(make_ordinal(32))
