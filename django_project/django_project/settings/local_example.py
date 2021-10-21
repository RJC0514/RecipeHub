"""
The local settings file is meant to include passwords or any other setting which
for whatever reason shouldn't be tracked by git. DO NOT specify them here! You
MUST copy this file, rename it to 'local.py', and then change the settings as
you like. The renamed file is in the gitignore and will not be tracked.
"""

DEBUG = True

if DEBUG:
	from .development import *
else:
	from .production import *


## Development local settings example ##########################################

# Custom database or logger..


## Production local settings example ###########################################

"""
The following can be used to generate a new SECRET_KEY
>>> python -c 'from django.core.management import utils; print(utils.get_random_secret_key())'
bb=nv9ytx@6!gmxy%6_0v76ze0hxdeu@2sa#s#ia!e$3m3@*r&
"""
# SECRET_KEY = 'a_secret_key'

# DATABASES['default']['PASSWORD'] = 'some_password'
